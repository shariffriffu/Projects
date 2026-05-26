import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
 
class DistributorPage extends StatefulWidget {
  final String jsonString;
  const DistributorPage({Key? key, required this.jsonString, required String jsonUrl}) : super(key: key);

  @override
  _DistributorPageState createState() => _DistributorPageState();
}

class _DistributorPageState extends State<DistributorPage> {
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
          body: mapData.isEmpty
              ? CircularProgressIndicator()
              : JsonWidgetData.fromDynamic(mapData, registry: registry).build(context: context),
        ),
      );

  void _exitApp() {
    SystemNavigator.pop(); // Use SystemNavigator to exit the app
  }
}
