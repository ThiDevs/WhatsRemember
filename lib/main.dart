import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Whats Remember ?'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        default:
          choice = "sexta";
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

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

  @override
  Widget build(BuildContext context) {
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
      await Firebase.initializeApp(
          // options: DefaultFirebaseOptions.currentPlatform,
          );

      await FirebaseFirestore.instance
          .collection("users")
          .doc("fvxHIp5RdP3kYBb0hbcp")
          .get();

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

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

    number.text = "27988710078";
    txt.text = "Coe";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Container(
              //   child: Row(
              //     children: <Widget>[
              //       Expanded(
              //         flex: 1,
              //         child: Column(
              //           children: <Widget>[
              //             Padding(
              //               padding: EdgeInsets.only(
              //                   bottom: 10, left: 100, right: 100),
              //               child: TextField(
              //                 controller: number,
              //                 decoration: InputDecoration(
              //                     border: InputBorder.none,
              //                     hintText: 'Digite seu numero'),
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsets.only(
              //                   bottom: 10, left: 100, right: 100),
              //               child: TextField(
              //                 controller: txt,
              //                 decoration: InputDecoration(
              //                     border: InputBorder.none,
              //                     hintText: 'Digite sua mensagem'),
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsets.only(bottom: 10, left: 100),
              //               child: Row(children: [
              //                 Column(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Radio(
              //                       value: 'segunda',
              //                       groupValue: _radioValue,
              //                       onChanged: radioButtonChanges,
              //                     ),
              //                     Text('Segunda'),
              //                   ],
              //                 ),
              //                 Column(
              //                   children: [
              //                     Radio(
              //                       value: 'terca',
              //                       groupValue: _radioValue,
              //                       onChanged: radioButtonChanges,
              //                     ),
              //                     Text('Terca'),
              //                   ],
              //                 ),
              //                 Column(
              //                   children: [
              //                     Radio(
              //                       value: 'quarta',
              //                       groupValue: _radioValue,
              //                       onChanged: radioButtonChanges,
              //                     ),
              //                     Text('quarta'),
              //                   ],
              //                 ),
              //                 Column(
              //                   children: [
              //                     Radio(
              //                       value: 'quinta',
              //                       groupValue: _radioValue,
              //                       onChanged: radioButtonChanges,
              //                     ),
              //                     Text('quinta'),
              //                   ],
              //                 ),
              //                 Column(
              //                   children: [
              //                     Radio(
              //                       value: 'sexta',
              //                       groupValue: _radioValue,
              //                       onChanged: radioButtonChanges,
              //                     ),
              //                     Text('sexta'),
              //                   ],
              //                 ),
              //               ]),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.only(
              //                   bottom: 10, left: 100, right: 100),
              //               child: ElevatedButton(
              //                 onPressed: _selectTime,
              //                 child: const Text('Selecionar as horas'),
              //               ),
              //             ),
              //             Padding(
              //                 padding: const EdgeInsets.only(
              //                     bottom: 10, left: 100, right: 100),
              //                 child: Row(
              //                   children: [
              //                     ElevatedButton(
              //                       onPressed: addUser, //addUser,
              //                       child: const Text('Salvar'),
              //                     ),
              //                     ElevatedButton(
              //                       onPressed: Testar, //addUser,
              //                       child: const Text('Testar'),
              //                     ),
              //                   ],
              //                 )),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("Combo"),
                    content: ListView(children: const [
                      TextField(
                        // controller: name1,
                        autofocus: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.person),
                            hintText: 'Nome - 1'),
                      ),
                    ]));
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
