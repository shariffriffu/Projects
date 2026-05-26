import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  var url = Uri.parse('http://support.tayanasoftware.com/cgi-bin/flashes');
  var response = await http.get(url);
  var jsonData = jsonDecode(response.body);
  var gifUrl = jsonData['gifUrl'];
  var gifResponse = await http.get(Uri.parse(gifUrl));
  var gifBytes = gifResponse.bodyBytes;
  // do something with the gifBytes, such as displaying it in a widget
}
