import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';

class HelpInfo extends StatelessWidget {
  final String url;

  HelpInfo({required this.url});

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
              title: Text('Help and Info'),
            ),
            body: ListView(
              padding: EdgeInsets.all(20),
              children: [
                SizedBox(height: 18),
                Text(
                  decodedMessage
                      .replaceAll(RegExp(r'<br>'), '\n')
                      .replaceAll(RegExp(r'<.*?>'), ''),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 52, 53, 46),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Help and info'),
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
