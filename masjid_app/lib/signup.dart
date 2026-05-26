// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(SignupPage());
}

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _mobilenumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String _selectedMohalla = '';
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _passwordsMatch = true;
  List<String> _mohallaList = [];

  @override
  void initState() {
    super.initState();
    // Fetch Mohalla list from URL when the widget is created
    _fetchMohallaList();
  }

  Future<void> _fetchMohallaList() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.6.101/fcgi-bin/new?mohalla=mohalla'));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the list
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _mohallaList = data.cast<String>();
        });
      } else {
        // If the server does not return a 200 OK response, print an error message
        print('Failed to load Mohalla list');
      }
    } catch (error) {
      // If there's an error during the HTTP request, print the error
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    _mobilenumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    String mobilenumber = _mobilenumberController.text;
    String email = _emailController.text;
    String mohalla = _selectedMohalla;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        _passwordsMatch = false;
      });
      return;
    }

    // Passwords match, continue with signup
    setState(() {
      _passwordsMatch = true;
    });

    // Add your signup logic here, such as creating a new account

    // For this example, we'll just print the signup details
    print('Mobile Number: $mobilenumber');
    print('Email: $email');
    print('Mohalla: $mohalla');
    print('Password: $password');
    print('Confirm Password: $confirmPassword');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _mobilenumberController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _selectedMohalla,
                onChanged: (value) {
                  setState(() {
                    _selectedMohalla = value!;
                  });
                },
                items: _mohallaList
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Mohalla',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: !_passwordsMatch ? 'Passwords do not match' : null,
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  errorText: !_passwordsMatch ? 'Passwords do not match' : null,
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _signUp,
                child: Text('Sign Up'),
              ),
              if (!_passwordsMatch)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Passwords do not match. Please try again.',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
