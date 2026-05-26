// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _serviceCodeController;
  late String serviceCode;

  @override
  void initState() {
    super.initState();
    _serviceCodeController = TextEditingController();
    _loadSettingsValues();
  }

  @override
  void dispose() {
    _serviceCodeController.dispose();
    super.dispose();
  }

  void _saveSettingsValues(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Service code', _serviceCodeController.text);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings Saved'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _loadSettingsValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String defaultServiceCode = '753';
    String? serviceCode = prefs.getString('Service code');

    if (serviceCode == null) {
      // if 'Service code' key does not exist in SharedPreferences, send hardcoded USSD code to server
      await prefs.setString('Service code', defaultServiceCode);

      // set default value and save in SharedPreferences
      await prefs.setString('Service code', defaultServiceCode);
      serviceCode = defaultServiceCode;
    }

    setState(() {
      this.serviceCode = serviceCode!;
      _serviceCodeController.text = serviceCode;
    });
  }

  Future<void> _sendUssdCodeToServer(String ussdCode) async {
    // replace this with your actual implementation to send the USSD code to the server
    print('Sending USSD code to server: $ussdCode');
  }

// this is just a placeholder function for demonstration purposes
  void ussdFunction(String ussdCode) {
    // replace this with your actual implementation to dial the USSD code
    print('Dialing USSD code: $ussdCode');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'General Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Service code'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextFormField(
                        controller: _serviceCodeController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            serviceCode = value;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _saveSettingsValues(context);
                      // Update the initial value of the TextFormField
                      // with the saved service code.
                      _serviceCodeController.text = serviceCode;
                    });
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
