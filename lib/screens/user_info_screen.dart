import 'dart:math';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lembre_zap/screens/sign_in_screen.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../firebase_options.dart';
import '../res/custom_color.dart';
import '../utils/authentication.dart';
import '../widgets/app_bar_title.dart.dart';
import 'package:http/http.dart' as http;

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
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
    var number = TextEditingController();

    late Country country;
    var numbertxt = MaskTextInputFormatter(mask: "+## (##) # ####-####");
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.firebaseNavy,
        title: AppBarTitle(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 180.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              _user.photoURL != null
                  ? ClipOval(
                      child: Material(
                        color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: Image.network(
                          _user.photoURL!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                        color: CustomColors.firebaseGrey.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: CustomColors.firebaseGrey,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 16.0),
              Text(
                'Hello',
                style: TextStyle(
                  color: CustomColors.firebaseGrey,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                _user.displayName!,
                style: TextStyle(
                  color: CustomColors.firebaseYellow,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '( ${_user.email!} )',
                style: TextStyle(
                  color: CustomColors.firebaseOrange,
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Cadastre seu número e teste !',
                style: TextStyle(
                    color: CustomColors.firebaseGrey.withOpacity(0.8),
                    fontSize: 14,
                    letterSpacing: 0.2),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: number,
                inputFormatters: [numbertxt],
                decoration: const InputDecoration(
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(15),
                    // ),
                    // suffixIcon: const Icon(Icons.numbers),
                    // prefix: Text("+" + number.text + "|"),
                    labelText: 'Número',
                    hintText: 'Digite seu numero'),
              ),
              const SizedBox(height: 18.0),
              Text(
                '( ${_user.phoneNumber ?? ""} )',
                style: TextStyle(
                  color: CustomColors.firebaseOrange,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
              ElevatedButton(
                  // style: ButtonStyle(
                  //   // backgroundColor: MaterialStateProperty.all(
                  //   //   CustomColors.googleBackground,
                  //   // ),
                  //   // shape: MaterialStateProperty.all(),
                  // ),
                  onPressed: () async {
                    var date = DateTime.now();
                    var number_send = numbertxt.unmaskText(number.text);
                    // setState(() {
                    //   _isSigningOut = true;
                    //   // number_code = country.countryCode;
                    // });

                    var txt =
                        "Envie de volta o seguinte código para esse chat: " +
                            date.year.toString() +
                            date.month.toString() +
                            date.second.toString() +
                            "-" +
                            Random().nextInt(100).toString() +
                            "-" +
                            Random().nextInt(100).toString();
                    var request = http.Request(
                        'GET',
                        Uri.parse(
                            'https://19f3-179-217-50-237.sa.ngrok.io/sendMessage/$number_send/$txt'));

                    http.StreamedResponse response = await request.send();

                    if (response.statusCode == 200) {
                      print(await response.stream.bytesToString());
                    } else {
                      print(response.reasonPhrase);
                    }
                    // Navigator.of(context).pushReplacement(_routeToSignInScreen());
                  },
                  child: Column(
                    children: [
                      const Text(
                        'Confirmar número do whatsapp !',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          // letterSpacing: 2,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 28.0),
              ElevatedButton(
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      favorite: <String>['BR', 'US'],
                      showPhoneCode: true,
                      onSelect: (Country country_res) {
                        setState(() {
                          // number.text = "+" + country.phoneCode;
                          // number_code = number.text;
                          country = country_res;
                        });
                        print('Select country: ${country_res.displayName}');
                      },
                      countryListTheme: CountryListThemeData(
                        backgroundColor: Colors.transparent,
                        flagSize: 10,
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
                              color: Colors.transparent.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Icon(Icons.flag)),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
