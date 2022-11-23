import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:lembre_zap/res/custom_color.dart';
import 'package:lembre_zap/screens/sign_in_screen.dart';
import 'package:lembre_zap/screens/user_info_screen.dart';
import 'package:lembre_zap/utils/authentication.dart';
import 'package:lembre_zap/widgets/app_bar_title.dart.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'firebase_options.dart';

// void main() {
//   runApp(const MyApp());
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  User _user;
  @override
  _MainScreenPageState createState() => _MainScreenPageState();

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: MyHomePage(title: 'Whats Remember ?', list: alarms),
  //   );
  // }
}

class Alarm {
  late String name;
  late String number;

  Point(String x, String y) {
    this.name = x;
    this.number = y;
  }
}

class _MainScreenPageState extends State<MainScreen> {
  // final String title;
  late User _user;

  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  bool carregado = false;
  List<Widget> alarms = <Widget>[];
  int _counter = 0;
  String? _radioValue = "";
  String choice = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void radioButtonChanges(String? value) {
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
    setState(() {});
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
    // await FirebaseFirestore.instance
    //     .collection("users")
    //     .doc("fvxHIp5RdP3kYBb0hbcp")
    //     .get();

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'number': number.text,
          'data': _radioValue,
          'hora': _time.format(context),
          'txt': txt.text,
          'login': _user.email
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<List<Widget>> getAlarms() async {
    alarms.clear();
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // var name = doc["name"];
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
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(doc.id)
                          .delete();

                      await getAlarms();
                      // alarms.where((element) => )
                      // setState(() {});
                    },
                  ),
                  const SizedBox(width: 2),
                ],
              ),
            ]));
      });
    });
    // setState(() {});
    return alarms;
  }

  @override
  void initState() {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        // title: 'Flutter layout demo',
        theme: ThemeData(
          primaryColorDark: Colors.black,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ).copyWith(
            secondary: Colors.orange,
          ),
          textTheme:
              const TextTheme(bodyText2: TextStyle(color: Colors.purple)),
        ),
        home: Scaffold(
          backgroundColor: CustomColors.firebaseNavy,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: CustomColors.firebaseNavy,
            title: Row(children: [
              AppBarTitle(),
              ElevatedButton(
                onPressed: (() {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => UserInfoScreen(
                        user: _user,
                      ),
                    ),
                  );
                }),
                child: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
              )
            ]),
          ),
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 20.0,
                  ),
                  child: Center(
                      child: FutureBuilder<List<Widget>>(
                    future: getAlarms(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Stack(children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20, bottom: 320.0),
                            child: ListView.builder(
                              itemCount: alarms.length,
                              itemBuilder: (context, index) {
                                return alarms[index];
                              },
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 400,
                              ),
                              Center(
                                  child: Column(
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.redAccent,
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _isSigningOut = true;
                                      });
                                      await Authentication.signOut(
                                          context: context);
                                      setState(() {
                                        _isSigningOut = false;
                                      });
                                      Navigator.of(context).pushReplacement(
                                          _routeToSignInScreen());
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Text(
                                        'Sign Out',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          )
                        ]);
                      }

                      /// handles others as you did on question
                      else {
                        return CircularProgressIndicator();
                      }
                    },
                    //     ListView.builder(
                    //   // Let the ListView know how many items it needs to build.
                    //   itemCount: t.length,
                    //   // Provide a builder function. This is where the magic happens.
                    //   // Convert each item into a widget based on the type of item it is.
                    //   itemBuilder: (context, index) {
                    //     var item = alarms[index];

                    //     return item;
                    //   },
                    // )
                    // Chip(
                    //   avatar: CircleAvatar(
                    //       backgroundColor: Colors.blue.shade900, child: Text('AH')),
                    //   label: Text('Hamilton'),
                    // ),
                    // Chip(
                    //   avatar: CircleAvatar(
                    //       backgroundColor: Colors.blue.shade900, child: Text('ML')),
                    //   label: Text('Lafayette'),
                    // ),
                    // Chip(
                    //   avatar: CircleAvatar(
                    //       backgroundColor: Colors.blue.shade900, child: Text('HM')),
                    //   label: Text('Mulligan'),
                    // ),
                    // Chip(
                    //   avatar: CircleAvatar(
                    //       backgroundColor: Colors.blue.shade900, child: Text('JL')),
                    //   label: Text('Laurens'),
                    // ),
                  )))),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String country_code = "";
                    String number_code = "";
                    number.text = "";
                    var numbertxt = MaskTextInputFormatter(
                        mask: "+$number_code (##) # ####-####");
                    return AlertDialog(
                        title: const Text("New WhatsAlarm"),
                        content: Column(
                          children: [
                            TextField(
                              controller: number,
                              inputFormatters: [
                                // const UpperCaseTextFormatter(),
                                numbertxt
                              ],
                              decoration: InputDecoration(
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(15),
                                  // ),
                                  // suffixIcon: const Icon(Icons.numbers),
                                  // prefix: Text("+" + number.text + "|"),
                                  labelText: 'Número',
                                  hintText: 'Digite seu numero'),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  showCountryPicker(
                                    context: context,
                                    favorite: <String>['BR', 'US'],
                                    showPhoneCode: true,
                                    onSelect: (Country country) {
                                      setState(() {
                                        number.text = "+" + country.phoneCode;
                                        number_code = number.text;
                                        country_code = country.countryCode;
                                      });
                                      print(
                                          'Select country: ${country.displayName}');
                                    },
                                    countryListTheme: CountryListThemeData(
                                      backgroundColor: Colors.transparent,
                                      flagSize: 20,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
                                      ),
                                      inputDecoration: InputDecoration(
                                        labelText: 'Search',
                                        hintText: 'Start typing to search',
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(Icons.flag)),
                            Flag.fromString(
                              country_code != "" ? country_code : "BR",
                              fit: BoxFit.cover,
                              height: 25, width: 25,
                              // height: 100,
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: <Widget>[
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //       bottom: 10, left: 100, right: 100),
                                        //   child: TextField(
                                        //     controller: number,
                                        //     decoration: InputDecoration(
                                        //         border: InputBorder.none,
                                        //         hintText: 'Digite seu numero'),
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 10,
                                              left: 100,
                                              right: 100),
                                          child: TextField(
                                            controller: txt,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'Digite sua mensagem'),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 10, left: 100),
                                          child: Row(children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Radio(
                                                  value: 'segunda',
                                                  groupValue: _radioValue,
                                                  onChanged: radioButtonChanges,
                                                ),
                                                Text('Segunda'),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Radio(
                                                  value: 'terca',
                                                  groupValue: _radioValue,
                                                  onChanged: radioButtonChanges,
                                                ),
                                                Text('Terca'),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Radio(
                                                  value: 'quarta',
                                                  groupValue: _radioValue,
                                                  onChanged: radioButtonChanges,
                                                ),
                                                Text('quarta'),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Radio(
                                                  value: 'quinta',
                                                  groupValue: _radioValue,
                                                  onChanged: radioButtonChanges,
                                                ),
                                                Text('quinta'),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Radio(
                                                  value: 'sexta',
                                                  groupValue: _radioValue,
                                                  onChanged: radioButtonChanges,
                                                ),
                                                Text('sexta'),
                                              ],
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10,
                                              left: 100,
                                              right: 100),
                                          child: ElevatedButton(
                                            onPressed: _selectTime,
                                            child: const Text(
                                                'Selecionar as horas'),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10,
                                                left: 100,
                                                right: 100),
                                            child: Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: addUser, //addUser,
                                                  child: const Text('Salvar'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: Testar, //addUser,
                                                  child: const Text('Testar'),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  });
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ));
  }
}
