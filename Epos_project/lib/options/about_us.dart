import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';

class AboutUs extends StatelessWidget {
  final String url;

  AboutUs({required this.url});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(Uri.parse(url)),
      builder: (context, AsyncSnapshot<http.Response> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          var data = jsonDecode(snapshot.data!.body);
          print(data);

          // Decode HTML entities
          var htmlUnescape = HtmlUnescape();
          var decodedMessage = htmlUnescape.convert(data['message']);

          return Scaffold(
            appBar: AppBar(
              title: Text('About Us'),
            ),
            body: ListView(
              padding: EdgeInsets.all(20),
              children: [
                SizedBox(height: 20),
                Text(
                  decodedMessage
                      .replaceAll(RegExp(r'<br>'), '\n')
                      .replaceAll(RegExp(r'<.*?>'), ''),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 52, 53, 46),
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'About Tayana:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(11, 28, 41, 1),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  data['description'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Email:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 3, 8, 12),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  data['email'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Phone:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 3, 8, 12),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  data['phone'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Contact Us'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
