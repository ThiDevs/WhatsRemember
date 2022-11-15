import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  var alarms = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Whats Remember ?', list: alarms),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.list})
      : super(key: key);

  final String title;
  final List<Widget> list;
  @override
  State<MyHomePage> createState() => _MyHomePageState(list);
}

class Alarm {
  late String name;
  late String number;

  Point(String x, String y) {
    this.name = x;
    this.number = y;
  }
}

bool carregado = false;

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.alarms);

  final List<Widget> alarms;
  int _counter = 0;
  String? _radioValue = "";
  String choice = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void radioButtonChanges(String? value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'quarta':
          choice = value!;
          break;
        case 'terca':
          choice = value!;
          break;
        case 'segunda':
          choice = value!;
          break;
        case 'quinta':
          choice = value!;
          break;
        case 'sexta':
          choice = value!;
          break;
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  var number = TextEditingController();
  var data = TextEditingController();
  var hora = TextEditingController();
  var txt = TextEditingController();

  Future<http.Response> Testar() {
    return http.get(Uri.parse(
        'https://95d1-2804-14d-ae83-87cc-34d2-c4-6910-43ba.sa.ngrok.io/sendMessage/' +
            number.text +
            '/' +
            txt.text));
  }

  Future<void> addUser() async {
    Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
    await FirebaseFirestore.instance
        .collection("users")
        .doc("fvxHIp5RdP3kYBb0hbcp")
        .get();

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'number': number.text,
          'data': _radioValue,
          'hora': _time.format(context),
          'txt': txt.text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<List<Widget>> getAlarms() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // var name = doc["name"];
        setState(() {
          var number = doc["number"];
          var txt = doc["txt"];
          alarms.add(Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: const Icon(Icons.alarm),
                  title: Text(number),
                  subtitle: Text(txt),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Edit'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      child: const Text('Remove'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 2),
                  ],
                ),
              ]));
        });
      });
    });
    return alarms;
  }

  @override
  Widget build(BuildContext context) {
    number.text = "27988710078";
    txt.text = "Coe";
    var t = <Widget>[];
    getAlarms().then((value) => t = value);
    return Scaffold(
      body: Center(
          child: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: t.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          var item = alarms[index];

          return item;
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text("New WhatsAlarm"),
                    content: Column(
                      children: [
                        TextField(
                          controller: number,
                          inputFormatters: [
                            // const UpperCaseTextFormatter(),
                            MaskTextInputFormatter(mask: " (##) # ####-####"),
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              suffixIcon: const Icon(Icons.numbers),
                              prefix: ElevatedButton(
                                  onPressed: () {
                                    showCountryPicker(
                                      context: context,
                                      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                      exclude: <String>['KN', 'MF'],
                                      favorite: <String>['BR'],
                                      //Optional. Shows phone code before the country name.
                                      showPhoneCode: true,
                                      onSelect: (Country country) {
                                        print(
                                            'Select country: ${country.displayName}');
                                      },
                                      // Optional. Sets the theme for the country list picker.
                                      countryListTheme: CountryListThemeData(
                                        // Optional. Sets the border radius for the bottomsheet.
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(40.0),
                                          topRight: Radius.circular(40.0),
                                        ),
                                        // Optional. Styles the search field.
                                        inputDecoration: InputDecoration(
                                          labelText: 'Search',
                                          hintText: 'Start typing to search',
                                          prefixIcon: const Icon(Icons.search),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: const Color(0xFF8C98A8)
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.flag)),
                              labelText: 'Número',
                              hintText: 'Digite seu numero'),
                        ),
                      ],
                    )

                    //   Container(
                    //     child: Row(
                    //       children: <Widget>[
                    //         Expanded(
                    //           flex: 1,
                    //           child: Column(
                    //             children: <Widget>[
                    //               Padding(
                    //                 padding: EdgeInsets.only(
                    //                     bottom: 10, left: 100, right: 100),
                    //                 child: TextField(
                    //                   controller: number,
                    //                   decoration: InputDecoration(
                    //                       border: InputBorder.none,
                    //                       hintText: 'Digite seu numero'),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: EdgeInsets.only(
                    //                     bottom: 10, left: 100, right: 100),
                    //                 child: TextField(
                    //                   controller: txt,
                    //                   decoration: InputDecoration(
                    //                       border: InputBorder.none,
                    //                       hintText: 'Digite sua mensagem'),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: EdgeInsets.only(bottom: 10, left: 100),
                    //                 child: Row(children: [
                    //                   Column(
                    //                     mainAxisAlignment: MainAxisAlignment.start,
                    //                     children: [
                    //                       Radio(
                    //                         value: 'segunda',
                    //                         groupValue: _radioValue,
                    //                         onChanged: radioButtonChanges,
                    //                       ),
                    //                       Text('Segunda'),
                    //                     ],
                    //                   ),
                    //                   Column(
                    //                     children: [
                    //                       Radio(
                    //                         value: 'terca',
                    //                         groupValue: _radioValue,
                    //                         onChanged: radioButtonChanges,
                    //                       ),
                    //                       Text('Terca'),
                    //                     ],
                    //                   ),
                    //                   Column(
                    //                     children: [
                    //                       Radio(
                    //                         value: 'quarta',
                    //                         groupValue: _radioValue,
                    //                         onChanged: radioButtonChanges,
                    //                       ),
                    //                       Text('quarta'),
                    //                     ],
                    //                   ),
                    //                   Column(
                    //                     children: [
                    //                       Radio(
                    //                         value: 'quinta',
                    //                         groupValue: _radioValue,
                    //                         onChanged: radioButtonChanges,
                    //                       ),
                    //                       Text('quinta'),
                    //                     ],
                    //                   ),
                    //                   Column(
                    //                     children: [
                    //                       Radio(
                    //                         value: 'sexta',
                    //                         groupValue: _radioValue,
                    //                         onChanged: radioButtonChanges,
                    //                       ),
                    //                       Text('sexta'),
                    //                     ],
                    //                   ),
                    //                 ]),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.only(
                    //                     bottom: 10, left: 100, right: 100),
                    //                 child: ElevatedButton(
                    //                   onPressed: _selectTime,
                    //                   child: const Text('Selecionar as horas'),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                   padding: const EdgeInsets.only(
                    //                       bottom: 10, left: 100, right: 100),
                    //                   child: Row(
                    //                     children: [
                    //                       ElevatedButton(
                    //                         onPressed: addUser, //addUser,
                    //                         child: const Text('Salvar'),
                    //                       ),
                    //                       ElevatedButton(
                    //                         onPressed: Testar, //addUser,
                    //                         child: const Text('Testar'),
                    //                       ),
                    //                     ],
                    //                   )),
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    );
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
