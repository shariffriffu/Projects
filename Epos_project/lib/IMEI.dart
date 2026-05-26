import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';
import 'package:ussd_service/ussd_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMEI Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _imeiNumber = '';

  Future<String> sendUssdRequest(String requestCode) async {
    String responseMessage;
    // ignore: unused_local_variable
    String responseCode;

    try {
      await Permission.phone.request();

      if (!await Permission.phone.isGranted) {
        throw Exception("Permission missing");
      }

      SimData simData = await SimDataPlugin.getSimData();

      responseMessage = await UssdService.makeRequest(
        simData.cards.first.subscriptionId,
        requestCode,
      );

      int _maxResponseLength = 500;
      if (responseMessage.length > _maxResponseLength) {
        responseMessage =
            responseMessage.substring(0, _maxResponseLength) + "...";
      }
    } on PlatformException catch (e) {
      responseCode = e is PlatformException ? e.code : "";
      responseMessage = e.message ?? '';
    }

    return responseMessage;
  }

  Future<void> getImeiNumber() async {
    String imei = await sendUssdRequest('*#06#');

    setState(() {
      _imeiNumber = imei;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMEI Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: getImeiNumber,
              child: Text('Get IMEI Number'),
            ),
            SizedBox(height: 16),
            Text(
              _imeiNumber.isNotEmpty ? 'IMEI Number: $_imeiNumber' : '',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
