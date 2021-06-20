import 'package:encrypt/encrypt.dart' as ENCRYPT;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:steel_crypt/steel_crypt.dart';

class EncryptService {
  final iv = ENCRYPT.IV.fromLength(16);
  // final key32 = CryptKey().genFortuna(len: 16);

  final encrypter = ENCRYPT.Encrypter(

    ENCRYPT.AES(
      ENCRYPT.Key.fromUtf8('bVLlri7CfSop6aipfT0flw=='),
    ),
  );


  String encrypt(String password) {
    // print("generated key :"  );
    // print(key32);
    final key = ENCRYPT.Key.fromUtf8('bVLlri7CfSop6aipfT0flw==');
    final iv = ENCRYPT.IV.fromLength(16);

    final encrypter = ENCRYPT.Encrypter(ENCRYPT.AES(key));

    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  void copyToClipboard(String decryptedPassword, BuildContext context) {
    final decrypted = encrypter.decrypt(
      ENCRYPT.Encrypted.fromBase64(decryptedPassword),
      iv: iv,
    );
    Clipboard.setData(
      ClipboardData(
        text: decrypted,
      ),
    );
    Fluttertoast.showToast(
      msg: "Password has been copied !",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
