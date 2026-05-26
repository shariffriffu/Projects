import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';
import 'package:ussd_service/ussd_service.dart';

void main() => runApp(MyApp());

class USSDCode {
  String name;
  String code;

  USSDCode({required this.name, required this.code});
}

List<USSDCode> ussdCodes = [
  USSDCode(
      name: 'Login',
      code: '*753*7*7783782*41*1234*110423*0*0*0*2*860882068612183*0#'),
  USSDCode(
      name: 'Recharge',
      code: '*753*7*7783782*27*1234*7400039*3900*0*0*2*860882068612183*2#'),
  USSDCode(
      name: 'Transfer',
      code: '*753*7*7783782*23*1234*7400039*50000*0*0*2*860882068612183*2#'),
  USSDCode(
      name: 'last request status',
      code: '*753*7*7783782*888*1234*0*0*0*0*2*860882068612183*0#'),
  USSDCode(
      name: 'retailer balance',
      code: '*753*7*7783782*25*1234*0*0*0*0*0*0*860882068612183*0#'),
  USSDCode(
      name: 'Balance ',
      code: '*753*7*7783782*25*0*0*0*0*0*2*860882068612183*0#'),
  USSDCode(
      name: 'Add Retailer',
      code: '*753*7*7783782*20*1234*0*0*1111*1234*0*0*860882068612183#'),
  USSDCode(
      name: 'delete Retailer',
      code: '*753*7*7783782*21*1111*1234*0*0*0*0*860882068612183*0#'),
  USSDCode(
      name: 'reset retailer password',
      code: '*753*7*7783782*43*1234*1122*0*0*0*2*860882068612183*0#'),
];

Future<String> sendUssdRequest(String requestCode) async {
  String responseMessage;
  try {
    await Permission.phone.request();
    if (!await Permission.phone.isGranted) {
      throw Exception("Permission missing");
    }

    SimData simData = await SimDataPlugin.getSimData();
    responseMessage = await UssdService.makeRequest(
        simData.cards.first.subscriptionId, requestCode);

    List<String> responseLines = responseMessage.split('\n');
    for (String line in responseLines) {
      if (line.contains("Enter number")) {
        // Handle the valid input according to application needs
      } else if (line.contains("User canceled")) {
        // Handle the user cancellation
      }
      // And so on
    }

    int maxResponseLength = 5000;
    if (responseMessage.length > maxResponseLength) {
      responseMessage = "${responseMessage.substring(0, maxResponseLength)}...";
    }
  } on PlatformException catch (e) {
    responseMessage = e.message ?? '';
  }

  return responseMessage;
}

class UssdPage extends StatefulWidget {
  @override
  _UssdPageState createState() => _UssdPageState();
}

class _UssdPageState extends State<UssdPage> {
  USSDCode? _selectedUssdCode;
  String _responseMessage = "";
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("USSD Page"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<USSDCode>(
              items: ussdCodes
                  .map(
                    (e) => DropdownMenuItem<USSDCode>(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedUssdCode = value;
                });
              },
              decoration: InputDecoration(
                labelText: "Select USSD code",
              ),
              value: _selectedUssdCode,
            ),
            SizedBox(height: 16),
            Image(
              image: NetworkImage(
                  'http://support.tayanasoftware.com/images/SELFCARE.gif'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_selectedUssdCode != null) {
                  setState(() {
                    _isLoading = true;
                  });

                  print(
                      "Sending USSD request for ${_selectedUssdCode?.name}: ${_selectedUssdCode?.code}");
                  String response =
                      await sendUssdRequest(_selectedUssdCode!.code);
                  setState(() {
                    _responseMessage = response;
                    _isLoading = false;
                  });

                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("${_selectedUssdCode!.name} USSD Response"),
                      content: SingleChildScrollView(
                        child: Text(_responseMessage),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text("Send USSD request"),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter USSD Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UssdPage(),
    );
  }
}
