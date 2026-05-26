import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:masjid_app/userpage.dart';

import 'signup.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  // Define TextEditingController for username and password
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green, // Set header color to green
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Login Page'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://w7.pngwing.com/pngs/238/167/png-transparent-moon-and-stars-star-five-pointed-star-star-decoration-thumbnail.png', // URL to your logo image
                  width: 100.0,
                  height: 100.0,
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: usernameController, // Connect the controller to the TextField
                  decoration: InputDecoration(
                    labelText: 'Username',
                    
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: passwordController, // Connect the controller to the TextField
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                                    keyboardType: TextInputType.number,

                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Set button color to green
                  ),
                  child: Text('Login'),
                  onPressed: () {
                    print("username: ${usernameController.text}");
                    print("password: ${passwordController.text}");
                    // Call the validateuser function with the entered username and password
                   final Response= validateuser(usernameController.text, passwordController.text);
                    if(Response == 'valid user'){
                      Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage()
                ));
                    }
                  },
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign up',
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 7, 7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> validateuser(String username, String password) async {
  try {
    print("username =$username&&&&&password=$password");
    final response = await http.get(Uri.parse('https://10.0.6.101/fcgi-bin/new?username=$username&password=$password'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the list
      final List<dynamic> data = json.decode(response.body);
      print('Data: $data'); // Print the data received from the server
    } else {
      // If the server does not return a 200 OK response, print an error message
      print('Failed to load Mohalla list');
    }
  } catch (error) {
    // If there's an error during the HTTP request, print the error
    print('Error: $error');
  }
}
