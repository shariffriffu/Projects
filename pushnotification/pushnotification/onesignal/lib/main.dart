// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_super_parameters, prefer_final_fields

import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController _textController = TextEditingController();
  String _encryptedData = '';
  String _decryptedData = '';

  String asd(String data) {
  String finalString = "";
  int dataLen = data.length;
  for (int i = 0; i < dataLen; i++) {
    finalString +=
        String.fromCharCode(data.codeUnitAt(i) + ((i + 1) % 100));
  }
  String finalData = base64Encode(utf8.encode(finalString));
  return finalData;
}

String qwe(String data) {
  String code = utf8.decode(base64.decode(data));
  String finalString = "";
  for (int i = 0; i < code.length; i++) {
    finalString +=
        String.fromCharCode(code.codeUnitAt(i) - ((i + 1) % 100));
  }
  return finalString;
}
String _encrypt() {
String para1 = "Epos";
String para2 = "Epos";
String para3 = "10.0.1";

String encryptedData  = asd(para1 + para2 + para3 );
print("encryptedData: " + encryptedData);


  return encryptedData;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Window'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter text',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _encryptedData = _encrypt();
                  });
                },
                child: Text('Encrypt'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _decryptedData = qwe(_textController.text) as String;
                  });
                },
                child: Text('Decrypt'),
              ),
            ],
          ),
          SizedBox(height: 20),
           SelectableText(
            'Encrypted data: $_encryptedData',
            style: TextStyle(fontSize: 16),
          ),
          SelectableText(
            'Decrypted data: $_decryptedData',
            style: TextStyle(fontSize: 16),
          ),
           SizedBox(height: 20),
          
        ],
      ),
    );
  }
}


