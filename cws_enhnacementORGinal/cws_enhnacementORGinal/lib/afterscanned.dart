// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';


class scanned extends StatefulWidget {
  final String jsonString;
  final String result;
  final String jsonUrl;
  const scanned({Key? key,required this.jsonString, required this.jsonUrl,required this.result}) : super(key: key);

  @override
  _scannedState createState() => _scannedState();
}

class _scannedState extends State<scanned> {
  Map<dynamic, dynamic> mapData = {};
  var registry = JsonWidgetRegistry.instance;

  Future<void> _readJson() async {
    final String response = widget.jsonString;
    final data = json.decode(response);
    setState(() {
      mapData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _readJson();
  }
  @override
  Widget build(BuildContext context) {
          String res = widget.result;
          res = "*****"+res.substring(res.length-2, res.length);
          print(res);

    if (mapData.isEmpty) {
      return CircularProgressIndicator();
    } else {
       registry.setValue('Scanned_number', res);
       print("inside scanned page");
      var widget = JsonWidgetData.fromDynamic(mapData, registry: registry);
      return widget.build   (context: context);
    }
  }
}