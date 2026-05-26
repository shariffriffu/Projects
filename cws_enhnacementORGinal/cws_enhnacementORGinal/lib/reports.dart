import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';


class reports extends StatefulWidget {
  final String jsonString;
  const reports({Key? key,required this.jsonString, required String jsonUrl}) : super(key: key);

  @override
  _reportsState createState() => _reportsState();
}

class _reportsState extends State<reports> {
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

    if (mapData.isEmpty) {
      return CircularProgressIndicator();
    } else {
      var widget = JsonWidgetData.fromDynamic(mapData, registry: registry);
      return widget.build   (context: context);
    }
  }
}