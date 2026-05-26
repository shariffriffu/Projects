// ignore_for_file: use_build_context_synchronously, avoid_print, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/menu/WithoutPrivilageDealerMenu.dart';
import 'package:untitled1/menu/WithoutPrivilageRetailerMenu.dart';
import 'package:untitled1/settings.dart';
import 'package:untitled1/ussd.dart';
import 'dart:io';

void main() => runApp(const MyApp1());

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/withoutPrivilageDealer': (context) => WithoutPrivilageDealerMenu(),
        '/withoutPrivilageRetailer': (context) => WithoutPrivilageRetailerMenu(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: [
         
        ],
      ),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const String logoUrl =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtNDpJTF3oq86kPR99eGf-8tFJ6VCi51-jsT68xrCSbQ&s';

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Image.network(
              logoUrl,
              height: 100,
              width: 100,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: usernameController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(110, 10, 110, 0),
            child: ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                final username = usernameController.text;
                final password = passwordController.text;

                if (username.isEmpty ||
                    password.isEmpty ||
                    
                    password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all the fields'),
                      backgroundColor: Colors.red,
                    ), 
                  );
                  return;
                }

                final prefs = await SharedPreferences.getInstance();
                String defaultServiceCode = '369';
                String? serviceCode = prefs.getString('Service code');

                if (serviceCode == null) {
                  serviceCode = defaultServiceCode;
                  await prefs.setString('Service code', defaultServiceCode);
                }

                String loginUssdCode =
                    '#$serviceCode*41*$password*160124*0*0*0*00*14160844545*$username#';

                print('Username: $username');
                print('Login USSD Code: $loginUssdCode');

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                if (loginUssdCode.isNotEmpty) {
                  String ussdResponse = await sendUssdRequest(loginUssdCode);
                  print(ussdResponse);
                  handleUssdResponse(ussdResponse, context);
                } else {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: const Text(
                            "Login USSD code not found in shared preferences"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("Ok"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  
void handleUssdResponse(String response, BuildContext context) async {
  Navigator.of(context).pop(); // Close the loading dialog

  if (response.trim().toLowerCase() == "admin") {
    // Directly navigate to the SettingsPage for "admin" response
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(),
      ),
    );
  } else if (response == "05*1") {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameController.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WithoutPrivilageDealerMenu()),
    );
  } else if (response == "02*1") {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameController.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WithoutPrivilageRetailerMenu(),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("USSD Response"),
          content: Text(response),
          actions: <Widget>[
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp1()),
                );
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }
}
}