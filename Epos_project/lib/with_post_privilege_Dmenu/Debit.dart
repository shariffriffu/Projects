// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ussd_and_login_page/Menu/distributers_menu.dart';

import '../ussd.dart';

void main() => runApp(const Debit());

class Debit extends StatelessWidget {
  const Debit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Debit';
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
                MaterialPageRoute(builder: (context) => const PostDmenu()),
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
    final retailerUserIdController = TextEditingController();
    final amountController = TextEditingController();
    final userIdController = TextEditingController();
    final passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 16),
            TextField(
              controller: retailerUserIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Retailer User ID',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: userIdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () async {
                final retailerUserId = retailerUserIdController.text;
                final amount = amountController.text;
                final username = userIdController.text;
                final password = passwordController.text;

                if (retailerUserId.isEmpty ||
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
                    '*$servicecode*7*$retailerUserId*23*$password*$retailerUserId*$amount*0*0*2*860882068612183*2#';
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
                            Navigator.of(context)
                                .pop(); // this is for dissabling the dailog box of error message
                            Navigator.of(context)
                                .pop(); // this is for loading dailogbox
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ]),
    );
  }
}
