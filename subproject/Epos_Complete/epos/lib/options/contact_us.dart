import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';

class ContactUs extends StatelessWidget {
  final String url;

  ContactUs({required this.url});

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
              title: Text('Contact Us'),
            ),
            body: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Text(
                  'Contact Details:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 3, 8, 12),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  decodedMessage
                      .replaceAll(RegExp(r'<br>'), '\n')
                      .replaceAll(RegExp(r'<.*?>'), ''),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Locations:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 3, 8, 12),
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data['locations'].map<Widget>((location) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location['type'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 3, 8, 12),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          location['address'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 3, 8, 12),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
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
