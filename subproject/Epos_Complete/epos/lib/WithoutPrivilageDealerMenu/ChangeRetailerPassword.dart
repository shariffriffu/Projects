// ignore_for_file: use_build_context_synchronously

import 'package:untitled1/USSDResponsePage.dart';
import 'package:untitled1/menu/WithoutPrivilageDealerMenu.dart';
import 'package:untitled1/ussd.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() => runApp(const ChangeRetailerPassword());

class ChangeRetailerPassword extends StatelessWidget {
  const ChangeRetailerPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Change Retailer Password';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WithoutPrivilageDealerMenu()),
              );
            },
            color: Colors.white,
          ),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final retailerIdController = TextEditingController();
    final newPasswordController = TextEditingController();
       final passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 16),
            TextField(
              controller: retailerIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Retailer ID',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newPasswordController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'New password',
              ),
            ),
            
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('submit'),
              onPressed: () async {
                final retailerId = retailerIdController.text;
                final newPassword = newPasswordController.text;
                
                final password = passwordController.text;

                if (retailerId.isEmpty ||
                    newPassword.isEmpty ||
                   
                    password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all the fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                showDialog(
                  context: context,
                  barrierDismissible:
                      false, // prevent the user from dismissing the dialog
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                // Construct the USSD request string
                final prefs = await SharedPreferences.getInstance();
                final servicecode = prefs.getString('Service code') ?? '';
                              final username = prefs.getString('username') ?? '';

                final ussdCode =
                    '*$servicecode*7*$retailerId*43*$password*$newPassword*0*0*0*0*860882068612183*$username#';
                print('USSD Code: $ussdCode');
                final response = await sendUssdRequest(ussdCode);
                print('USSD Response: $response');

                // Show theresponse message to the user
                showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('USSD Response'),
              content: Text(response),
              actions: [
                TextButton(
                  onPressed: () {
                    // Close the USSD response dialog
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to the USSD response page with the response
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => USSDResponsePage(response: response),
                      ),
                    );
                  },
                  child: const Text('Save and Print'),
                ),
              ]);
                  },
                );
              },
            ),
          ]),
    );
  }
}
