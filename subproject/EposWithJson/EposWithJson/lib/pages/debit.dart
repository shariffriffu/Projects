import 'dart:convert';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';


class debit extends StatefulWidget {
  final String jsonString;
  const debit({Key? key,required this.jsonString, required String jsonUrl}) : super(key: key);

  @override
  _debitState createState() => _debitState();
}

class _debitState extends State<debit> {
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