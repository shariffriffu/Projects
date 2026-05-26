import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ussd_and_login_page/Menu/distributers_menu.dart';
import 'package:ussd_and_login_page/Menu/post_distributers_menu.dart';
import 'package:ussd_and_login_page/ussd.dart';

void main() => runApp(const DeleteRetailers());

class DeleteRetailers extends StatelessWidget {
  const DeleteRetailers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Delete Retailers';
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
                MaterialPageRoute(builder: (context) => const DMenu()),
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
    final retailer_idController = TextEditingController();
    final useridController = TextEditingController();
    final passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 16),
            TextField(
              controller: retailer_idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Retailer  User-Id',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: useridController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your username',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () async {
                final retailer_id = retailer_idController.text;
                final username = useridController.text;
                final password = passwordController.text;
                if (retailer_id.isEmpty ||
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
                    '*$servicecode*7*$retailer_id*21*$username*$password*0*0*0*0*860882068612183*0#';
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
