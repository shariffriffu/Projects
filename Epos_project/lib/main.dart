import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ussd_and_login_page/Menu/distributers_menu.dart';
import 'package:ussd_and_login_page/Menu/post_distributers_menu.dart';
import 'package:ussd_and_login_page/Menu/Post_retailers_menu.dart';
import 'package:ussd_and_login_page/Menu/Retailers_Menu.dart';
import 'package:ussd_and_login_page/Menu/settings.dart';
import 'package:ussd_and_login_page/ussd.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'CWS E-Pos';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Settings') {
                  // Do something when 'Settings' is selected
                  // For example, navigate to a settings screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Settings'}
                    .map((String choice) => PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        ))
                    .toList();
              },
            ),
          ],
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  get loginUssdCode => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'CWS Login',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
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
                    // ignore: unused_local_variable
                    final username = nameController.text;
                    // ignore: unused_local_variable
                    final password = passwordController.text;
                    //Check if the entered username and password are correct
                    if (nameController.text == "" &&
                        passwordController.text == "") {
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
                      // Call the USSD code

                      // Retrieve the login USSD code from shared preferences
                      final prefs = await SharedPreferences.getInstance();
                      final servicecode = prefs.getString('Service code') ?? '';

                      String loginUssdCode = '*$servicecode#';
                      // String loginUssdCode =
                      //     '*$servicecode*7*7783782*41*1234*060423*0*0*0*00*860882068612183*0#';
                      print(loginUssdCode);
// Call the USSD code
                      if (loginUssdCode.isNotEmpty) {
                        String ussdResponse =
                            await sendUssdRequest(loginUssdCode);
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
                                    // hide the loading dialog box
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      // Show an error message if the username and password are incorrect
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content:
                                const Text("Incorrect username or password"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // hide the loading dialog box
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                )),
          ],
        ));
  }
}

// ignore: camel_case_types
void handleUssdResponse(String response, BuildContext context) {
  if (response == "1") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DMenu()),
    );
  } else if (response == "1") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RMenu()),
    );
  } else if (response == "USSD_RETURN_FAILURE") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostDmenu()),
    );
  } else if (response == "") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Post_RMenu()),
    );
  } else {
    Navigator.of(context).pop(); // hide the loading dialog box
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("Invalid user"),
          actions: <Widget>[
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                // hide the loading dialog box
              },
            ),
          ],
        );
      },
    );
  }
}
