import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:SecKee/pages/passContaioner.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  var containsEncryptionKey = await secureStorage.containsKey(key: 'key');

  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'key', value: base64UrlEncode(key));
  }
  //
  var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));

  await Hive.openBox(
    'passwords',
    encryptionCipher: HiveAesCipher(encryptionKey),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var clicked = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Security Keys',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.lightBlue[900],
        accentColor: Colors.lightBlue,
        scaffoldBackgroundColor: Color.fromRGBO(0, 172, 255,1),
        textTheme: TextTheme().apply(
          fontFamily: "customFont",
        ),
      ),
      home: FingerPrintAuth(),
    );
  }
}

class FingerPrintAuth extends StatefulWidget {
  @override
  _FingerPrintAuthState createState() => _FingerPrintAuthState();
}

class _FingerPrintAuthState extends State<FingerPrintAuth> {
  var clickCount = 0;
  bool authFuncd = false;
  void authFunc() async {
    try {
      var localAuth = LocalAuthentication();
      authFuncd = await localAuth.authenticate(
        localizedReason: 'Authentication to reach SecKee',
        biometricOnly: true,
        useErrorDialogs: true,
      );
      if (authFuncd) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => PassContaioner(),
          ),
        );
      } else {
        setState(() {});
      }
    } catch (e) {

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Sorry",
            ),
            content: Text(
              "You need to setup Fingerprint Authentication to use SecKee!",

            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                ),
              ),
            ],
          ),
        );
      }

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Welcome to SecKee"),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //
            SizedBox(
              height: 15.0,
            ),
            //
            if (!authFuncd)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new GestureDetector(
                  onTap: (){
                              this.clickCount++;

                  },
                            child: Image(
                            image: AssetImage("images/backgroundpng.png"),
                            fit: BoxFit.cover,
                            )
                            ),

                  SizedBox(
                    height: 15.0,
                  ),
                  //
                  TextButton(

                    onPressed: () {
                      if(clickCount>4)
                        authFunc();
                      clickCount=0;
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Click here for authentication !",
                          style: TextStyle(
                            // backgroundColor: Color.fromRGBO(0, 172, 255,1) ,
                            color: Color.fromRGBO(255, 255, 255,1),
                            fontSize: 20.0,
                          ),
                        ),
                        //
                        SizedBox(
                          width: 10.0,
                        ),

                      ],
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
