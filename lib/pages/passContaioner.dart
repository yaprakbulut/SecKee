import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:SecKee/controller/encrypter.dart';
import 'package:SecKee/icons_map.dart' as CustomIcons;

class PassContaioner extends StatefulWidget {
  @override
  _PasswordsState createState() => _PasswordsState();
  VoidCallback callback;
}
String passGenerator(double _numberCharPassword) {
  String _leLetters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String _numbers = "0123456789";
  String _special = "*-/-_.,!?=";
  String _allowedChars = "";
  _allowedChars += (_leLetters );
  _allowedChars += (_numbers );
  _allowedChars += (_special );

  int i = 0;
  String _result = "";

  //Create password
  while (i < _numberCharPassword.round()) {
    int randomInt = Random.secure().nextInt(_allowedChars.length);
    _result += _allowedChars[randomInt];
    i++;
  }

  return _result;
}
class _PasswordsState extends State<PassContaioner> {
  Box box = Hive.box('passwords');
  bool longPressed = false;
  EncryptService _encryptService = new EncryptService();
  final TextEditingController _controller = TextEditingController();

  void refresh() {
    setState(() {});
  }

  Future fetch() async {
    if (box.values.isEmpty) {
      return Future.value(null);
    } else {
      return Future.value(box.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:    Color.fromRGBO(255, 255, 255,1),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Passwords",
          style: TextStyle(
            // fontFamily: "customFont",
            fontSize: 22.0,
          ),
        ),

      ),
      //
      floatingActionButton: FloatingActionButton(
        onPressed: insertDB,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        backgroundColor: Colors.lightBlue[900],
      ),
      //
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      //
      body: FutureBuilder(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Text(
                "There is no saved password. Tap '+' buton to create new one.",
                style: TextStyle(
                  fontSize: 22.0,
                  // fontFamily: "customFont",
                  color: Color.fromRGBO(0, 172, 255, 1),
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Map data = box.getAt(index);
                return Card(
                  margin: EdgeInsets.all(
                    12.0,
                  ),
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 20.0,
                      ),
                      tileColor: Color.fromRGBO(0, 172, 255, 1),
                      leading: CustomIcons.icons[data['passTitle']] ??
                          Icon(
                            Icons.lock,
                            size: 32.0,
                          ),
                      title: Text(
                        "${data['passTitle']}",
                        style: TextStyle(
                          fontSize: 22.0,
                          // fontFamily: "customFont",
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "${data['userName']}\nClick copy icon to copy passsword",
                        style: TextStyle(
                          fontSize: 16.0,
                          // fontFamily: "customFont",
                        ),
                      ),

                      trailing: IconButton(
                        onPressed: () {
                          _encryptService.copyToClipboard(
                            data['password'],
                            context,
                          );
                        },
                        icon: Icon(
                          Icons.copy_rounded,
                          size: 36.0,
                        ),
                      ),
                    ),
                    secondaryActions: <Widget>[

                      IconSlideAction(
                        closeOnTap: true,
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialog(
                                  title: const Text('Are you sure?'),
                                  content: const Text(
                                      'Selected Password Will  Delete'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                        print("dataBAse ?");
                                        print(snapshot.data);
                                        print("generated passs: ");
                                        print(passGenerator(10));

                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        box.deleteAt(index);
                                        snapshot.data.remove(index);
                                        Navigator.pop(context, 'OK');
                                        fetch();
                                        refresh();


                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                          );

                          // box.delete(index);


                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void insertDB() {
    String passTitle;
    String userName;
    String password;
    _controller.value = _controller.value.copyWith(
      text: "",
      selection: TextSelection.collapsed(offset: 0),
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          Container(
            color: Colors.white,
            padding: MediaQuery
                .of(context)
                .viewInsets,
            child: Form(

              child: Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  TextFormField(
                    decoration:
                    new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(0, 172, 255, 1), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(0, 172, 255, 1), width: 2.0),
                      ),
                        labelText: "Service",
                        labelStyle: TextStyle(

                          color: Color.fromRGBO(0, 172, 255, 1),
                        )
                    ),


                    style: TextStyle(
                      fontSize: 18.0,
                      // fontFamily: "customFont",
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                    onChanged: (val) {
                      passTitle = val;
                    },
                    validator: (val) {
                      if (val
                          .trim()
                          .isEmpty) {
                        return "Enter A Value !";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(0, 172, 255, 1), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(0, 172, 255, 1), width: 2.0),
                      ),
                      labelText: "Username",
                        labelStyle: TextStyle(

                          color: Color.fromRGBO(0, 172, 255, 1),
                        )
                    ),
                    style: TextStyle(
                      fontSize: 18.0,
                      // fontFamily: "customFont",r
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),

                    onChanged: (val) {
                      userName = val;
                    },
                    validator: (val) {
                      if (val
                          .trim()
                          .isEmpty) {
                        return "Enter A Value !";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    controller: _controller,
                    decoration:
                    InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(0, 172, 255, 1), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(0, 172, 255, 1), width: 2.0),
                      ),
                      suffixIcon: IconButton(
                        color: Color.fromRGBO(0, 172, 255, 1),
                        onPressed: () =>{
                          password = passGenerator( 10),
                          _controller.value = _controller.value.copyWith(
                          text: password,
                          selection: TextSelection.collapsed(offset: password.length),
                          ),
                        },
                        icon: Icon(Icons.vpn_key_outlined),
                      ),
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(0, 172, 255, 1),
                      )
                    ),

                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      // fontFamily: "customFont",
                    ),
                    onChanged: (val) {
                      password = val;
                    },

                    validator: (val) {
                      if (val
                          .trim()
                          .isEmpty) {
                        return "Enter A Value !";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // encrypt
                      password = _encryptService.encrypt(password);
                      // insert into db
                      Box box = Hive.box('passwords');
                      // insert
                      var value = {
                        'passTitle': passTitle.toLowerCase(),
                        'userName': userName,
                        'password': password,
                      };
                      box.add(value);

                      Navigator.of(context).pop();
                      refresh();

                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 20.0,
                        // fontFamily: "customFont",
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 50.0,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(0, 172, 255, 1),
                        // 0xff892cdc
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
