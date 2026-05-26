// ignore_for_file: unnecessary_import, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:device_info/device_info.dart';

import 'CustomWidget/datepicker.dart'; // Import your custom date picker widget here
import 'CustomWidget/json_prefersized_widjet.dart';
import 'CustomWidget/json_tab.dart';
import 'CustomWidget/json_tab_bar.dart';
import 'CustomWidget/json_tab_bar_view.dart'; // Import your custom date picker widget here

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());

  var registry = JsonWidgetRegistry.instance;
  HttpOverrides.global = MyHttpOverrides();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController todateController = TextEditingController();
  registry.setValue('fromDateController', fromDateController);
  registry.setValue('toDateController', todateController);
  registry.setValue('border', InputBorder.none);
 registry.setValue('textFieldDecoration', InputBorder.none);
 registry.setValue("preferred_size", const Size.fromHeight(200.0));
  registry.registerFunctions({
    'selectFromDate': ({args, required registry}) => () async {
          print("Clicked");
          String? selected = await showDatePickerDialog(
              'fromDate', navigatorKey.currentContext);
          if (selected != null) {
            fromDateController.text = selected.toString();
          }
        },
    'selectToDate': ({args, required registry}) => () async {
          print("Clicked");
          String? selectedTo =
              await showDatePickerDialog('toDate', navigatorKey.currentContext);
          if (selectedTo != null) {
            todateController.text = selectedTo.toString();
          }
        },
    'print': ({args, required registry}) => () async {
          print("pressed submit");
        },  'set_value': ({args, required registry}) => () async {
          print("pressed submit");
        },'submitAction': ({args, required registry}) => () async {
          print("pressed submit");
        },'trackGlimpse': ({args, required registry}) => () async {
          print("pressed submit");
        },
  });

  registry.registerCustomBuilder(
    DatePickerBuilder.kType,
    JsonWidgetBuilderContainer(
      builder: (map, {registry}) => DatePickerBuilder.fromDynamic(map),
    ),
  );
  registry.registerCustomBuilder(
    preferred_sizeBuilder.kType,
    JsonWidgetBuilderContainer(
      builder: (map, {registry}) => preferred_sizeBuilder.fromDynamic(map),
    ),
  );

  registry.registerCustomBuilder(
      TabBarViewBuilder.kType,
      JsonWidgetBuilderContainer(
          builder: (map, {registry}) => TabBarViewBuilder.fromDynamic(map)));
 
  registry.registerCustomBuilder(
      TabBarBuilder.kType,
      JsonWidgetBuilderContainer(
          builder: (map, {registry}) => TabBarBuilder.fromDynamic(map)));
 
  registry.registerCustomBuilder(
      TabBuilder.kType,
      JsonWidgetBuilderContainer(
          builder: (map, {registry}) => TabBuilder.fromDynamic(map)));
}

class HomePage extends StatefulWidget {
  final String jsonString;
  const HomePage({Key? key, required this.jsonString}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  Map<dynamic, dynamic> mapData = {};
  var registry = JsonWidgetRegistry.instance;

  Future<void> _readJson() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/newjson.json');
      final data = json.decode(response);

      setState(() {
        mapData = data;
      });
    } catch (e, stackTrace) {
      print("Error reading json: $e");
      print("$stackTrace");
    }
  }

  @override
  void initState() {
    super.initState();
    _readJson();
    getDeviceId();
    TabController tabController = TabController(length: 2, vsync: this);
    registry.setValue('tabBarController', tabController);
final Transactions = [
      {"title": "Recharge for prepaid", "msisdn": "12435465789", "date": "10 jun,05:40 Pm", "price": "NU 5", "type": "B-Wallet", "status": "Failed!"},
      {"title": "Recharge for prepaid", "msisdn": "12343254365","date": "11 jun,06:20 Am",  "price": "NU 5", "type": "B-Wallet", "status": ""},
      {"title": "Recharge for prepaid", "msisdn": "DSGS1245235","date": "12 jun,07:21 Pm",  "price": "NU 5", "type": "B-Wallet", "status": ""},
      {"title": "Recharge for prepaid", "msisdn": "ASFFA131244","date": "13 jun,07:40 Pm",  "price": "NU 5", "type": "B-Wallet", "status": "Failed!"}
    ];


        registry.setValue("transaction", Transactions);

  }

  @override
  Widget build(BuildContext context) {
    if (mapData.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      var widget = JsonWidgetData.fromDynamic(mapData, registry: registry);
      return widget.build(context: context);
    }
  }
}

Future<String?> showDatePickerDialog(
    String fieldId, BuildContext? context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context!,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    // Handle selected date
    print('Selected date: $pickedDate');
    return '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}';
  }
  return null;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(jsonString: ''),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<String?> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print(androidInfo.androidId);
    return androidInfo.androidId; // Unique Android ID
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor; // Unique iOS ID
  }
  return null;
}
