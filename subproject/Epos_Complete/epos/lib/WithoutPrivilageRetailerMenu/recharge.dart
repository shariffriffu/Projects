// ignore_for_file: use_build_context_synchronously

import 'package:untitled1/USSDResponsePage.dart';
import 'package:untitled1/menu/WithoutPrivilageRetailerMenu.dart';
import 'package:untitled1/ussd.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const Recharge());

class Recharge extends StatelessWidget {
  const Recharge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Recharge';
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
                MaterialPageRoute(builder: (context) => const WithoutPrivilageRetailerMenu()),
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
    final mobileNoController = TextEditingController();
    final amountController = TextEditingController();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 16),
            TextField(
              controller: mobileNoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mobile NO',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final num? amount = num.tryParse(value);
                if (amount == null) {
                  return 'Please enter a valid number';
                }
                // Multiply the input by 100
                final multipliedAmount = amount * 100;
                // Update the controller value to the multiplied amount
                amountController.text = multipliedAmount.toString();
                // Return null to indicate validation passed
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
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
              child: const Text('Submit'),
              onPressed: () async {
                final mobileNo = mobileNoController.text;
                final amount = amountController.text;
                final username = usernameController.text;
                final password = passwordController.text;

                if (mobileNo.isEmpty ||
                    amount.isEmpty ||
                    username.isEmpty ||
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
                final ussdCode =
                    '*$servicecode*7*$mobileNo*27*$password*$mobileNo*${amountController.text}*0*0*2*860882068612183*2#';
                print('USSD Code: $ussdCode');
                final response = await sendUssdRequest(ussdCode);
                print('USSD Response: $response');

                // Show the response message to the user
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
