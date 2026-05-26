// ignore_for_file: file_names, library_private_types_in_public_api, unused_element, prefer_const_declarations, prefer_const_constructors, deprecated_member_use

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

class mainPage extends StatefulWidget {
  final String jsonString;
  const mainPage({Key? key, required this.jsonString, required String jsonUrl}) : super(key: key);

  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  Map<dynamic, dynamic> mapData = {};
  var registry = JsonWidgetRegistry.instance;
  bool _isLoading = true; // Add a flag to track loading state

  Future<void> _readJson() async {
    final String response = widget.jsonString;
    final data = json.decode(response);
    setState(() {
      mapData = data;
      _isLoading = false; // Set loading flag to false when data is loaded
    });
  }

  @override
  void initState() {
    super.initState();
    _readJson();
  }

  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      final difference = DateTime.now().difference(timeBackPressed);
      final isExitWarningEnabled = difference >= Duration(seconds: 2);
      timeBackPressed = DateTime.now();

      if (isExitWarningEnabled) {
        final message = 'Press back again to exit';
        Fluttertoast.showToast(msg: message, fontSize: 20);
        return false;
      } else {
        return true;
      }
    },
    child: Scaffold(
      body: !_isLoading ? JsonWidgetData.fromDynamic(mapData, registry: registry).build(context: context) : SizedBox(),
    ),
  );

  void _exitApp() {
    SystemNavigator.pop(); // Use SystemNavigator to exit the app
  }
}
