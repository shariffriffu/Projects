// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unrelated_type_equality_checks, prefer_interpolation_to_compose_strings, unnecessary_import, equal_keys_in_map, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:device_info/device_info.dart';

import 'package:flutter/material.dart';

import 'CustomWidget/datepicker.dart';
import 'CustomWidget/json_carousel_slider.dart';
import 'CustomWidget/json_drawer.dart';
import 'CustomWidget/json_prefersized_widjet.dart';
import 'database.dart';

final navigatorKey = GlobalKey<NavigatorState>();
String one = "";
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
void main() {
  runApp(const MyApp());


  var registry = JsonWidgetRegistry.instance;
    HttpOverrides.global = MyHttpOverrides();

  registry.registerFunctions({
    'SUB': ({args, required registry}) => () async {
      print("clicked");
        print('inside SUB: '+args?[1]);
      var nav =args?[1];
      print("nav"+nav);
    },   'signUp': ({args, required registry}) => () async {
      print("clicked");
        
      }, 'selectFromDate': ({args, required registry}) => () async {
      print("clicked");
      _showImageDialog();
        
      },'selectToDate': ({args, required registry}) => () async {
      print("clicked");
        
      }, 'showFAQ': ({args, required registry}) => () async {
      print("clicked");
        
      },    'togglePinVisibility': ({args, required registry}) => () async {
        print("clicked");
          
      },   'pin': ({args, required registry}) => () async {
      print("clicked");
        
    }, 'print': ({args, required registry}) => () async {
      print("clicked");
        
    },'dummyFunction': ({args, required registry}) => () async {
      print("clicked");
        
    },'fingerFunctionsubmit': ({args, required registry}) => () async {
      print("clicked");
        
    },
     'Logout': ({args, required registry}) => () async {
      print("clicked");
        
    },'vouchersubmit': ({args, required registry}) => () async {
      print("clicked");
        
    },
    
    
    
    'validateForm': ({args, required registry}) => () async {
          print("inside validateForm");

          print('Recharge:  $args[1]');
          String argsAsString = args.toString();

          // Print the list
          print('Recharge: $argsAsString');

          int i = 1;
          while (true) {
            final id = 'ID($i)';
            final value = registry.getValue(id);
            if (value == null) {
              print('No value found for $id');
              break; // Exit the loop if value is null
            }
            print('Registry value for $id: $value');
            i++; // Increment i for the next iteration
          }

          if (argsAsString == "[form_context,recharge]") {
            print('Entered if condition: '+'argsAsString(1)');
            Color color = Color(0x9F05578A);
            print(color);

          }

          print("function called+$num");
        },
   'QrScan': ({args, required registry}) async {
  print("inside Scan_function");
},
   'validateAndSubmitForm': ({args, required registry}) async {
  print("inside Scan_function");
},
'Read_functionScan': ({args, required registry}) async {
  print("inside Scan_function");
},

'showAlert': ({args, required registry}) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text('This is an alert message.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
},

    'TotalSalesPerDealer': ({args, required registry}) => () async {
          print("inside TotalSalesPerDealer");
        },

    'QrScan': ({args, required registry}) => () async {
          print("inside Scan_function");
        },

    'Recharge_submit': ({args, required registry}) => () async {},
    'addfingerprint': ({args, required registry}) => () async {
          print("inside addfingerprint");
        },

    'Read_function': ({args, required registry}) => () async {
          print("inside Read_function");
        },
    'Reset_function': ({args, required registry}) => () async {
          print("inside Reset_function");
        },

    'fingerFunction': ({args, required registry}) => () async {
          print("inside fingerFunction");
        },

    'Readfortransferfunction': ({args, required registry}) => () async {},
    'Restfortransferfunction': ({args, required registry}) => () async {
          print("inside Reset_function");
        },

    'Transfer_submit': ({args, required registry}) => () async {},

    'RetailerBalance_submit': ({args, required registry}) => () async {},

    'AddRetailer_submit': ({args, required registry}) => () async {
          print("inside AddRetailer_submit");
        },

    'DeleteRetailer_submit': ({args, required registry}) => () async {
          print("inside DeleteRetailer_submit");
        },

    'debit_Submit': ({args, required registry}) => () async {},
    'changeRetailerPassword_Submit': ({args, required registry}) => () async {
          print("inside changeRetailerPassword_Submit");
        },

    //functions of the buttons

    'recharge': ({args, required registry}) => () async {
          print("inside Options_recharge");
        },
    'Transfer': ({args, required registry}) => () async {
          print("inside Transfer");
        },

    'Balance': ({args, required registry}) => () async {
          print("inside Balance");
        },
    'PartnerService': ({args, required registry}) => () async {
          print("inside Balance");
        },
    'DataBoosters': ({args, required registry}) => () async {
          print("inside Balance");
        },
    'BillPayment': ({args, required registry}) => () async {
          print("inside Balance");
        },

    'Settings': ({args, required registry}) => () async {
          print("inside Balance");
        },

    'Retailer_Balance': ({args, required registry}) => () async {
          print("inside Retailer_Balance");
        },

    'Last_Request': ({args, required registry}) => () async {
          print("inside Last_Request");
        },

    'Add_Retailer': ({args, required registry}) => () async {
          print("inside Add_Retailer");
        },

    'View_Retailer': ({args, required registry}) => () async {
          print("inside View_Retailer");
        },

    'Delete_Retailer': ({args, required registry}) => () async {
          print("inside Delete_Retailer");
        },

    'Change_Retailer_password': ({args, required registry}) => () async {
          print("inside Change_Retailer_password");
        },

    'Debit': ({args, required registry}) => () async {
          print("inside Debit");
        },

    'Reports': ({args, required registry}) => () async {
          print("inside Reports");
        },
    'TotalSalePerDealer': ({args, required registry}) => () async {
          print("inside TotalSalePerDealer");
        },
    'TotalSalePerPos': ({args, required registry}) => () async {
          print("inside TotalSalePerPos");
        },
    'BalancePerDealer': ({args, required registry}) => () async {
          print("inside BalancePerDealer");
        },
    'UtiltyBillPayment': ({args, required registry}) => () async {
          print("inside BalancePerDealer");
        },
    'TicketToFerry': ({args, required registry}) => () async {
          print("inside BalancePerDealer");
        },
    'BusPas': ({args, required registry}) => () async {
          print("inside BalancePerDealer");
        },

    'image': ({args, required registry}) => () async {
          print("inside image");
        },
    'Options_help': ({args, required registry}) => () async {
          print("inside Options_recharge");
        },

    'Options_aboutUs': ({args, required registry}) => () async {},

    'Options_contactUs': ({args, required registry}) => () async {},

    'Options_logout': ({args, required registry}) => () async {
          print("inside logout");
        },
        
          
  });
registry.setValue(
        "options",
        CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            initialPage: 0));
  registry.registerCustomBuilder(
      DrawerBuilder.kType, // from generate file
      JsonWidgetBuilderContainer(
        builder: (map, {registry}) =>
            DrawerBuilder.fromDynamic(map), // from generate file
      ));
       
       registry.registerCustomBuilder(
      CarouselSliderBuilder.kType,
      JsonWidgetBuilderContainer(
        builder: (map, {registry}) => CarouselSliderBuilder.fromDynamic(map),
      )); 
      registry.registerCustomBuilder(
      preferred_sizeBuilder.kType,
      JsonWidgetBuilderContainer(
        builder: (map, {registry}) => preferred_sizeBuilder.fromDynamic(map),
      ));  registry.registerCustomBuilder(
      DatePickerBuilder.kType,
      JsonWidgetBuilderContainer(
        builder: (map, {registry}) => DatePickerBuilder.fromDynamic(map),
      ));
}

class HomePage extends StatefulWidget {
  final String jsonString;
  const HomePage({Key? key, required this.jsonString}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<dynamic, dynamic> mapData = {};
  var registry = JsonWidgetRegistry.instance;

  Future<void> _readJson() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/newjson.json');
      final data = json.decode(response);

      setState(() {
        mapData = data ;
      });
    } catch (e, stackTrace) {
      print("TBR: Error reading json: $e");
      print("TBR: $stackTrace");
    }
  }

  Future<void> _readJsonfunction() async {
    try {
      String response = await rootBundle.loadString('assets/json/newjson.json');
      final one = json.decode(response);
      final originalUrl = one['url']; // Accessing the URL value

      print("TBR: Parsed data is $originalUrl");
      print("TBR: Parsed data i1111111111s");

// Assume you have retrieved the values for `password` and `username`
      String password = '21566';
      String username = '223213';
      print("TBR: Parsed data i22222222222222222s");
// Replace placeholders in the URL with dynamic values
      String replacedUrl = originalUrl
          .replaceFirst('\$password', password)
          .replaceFirst('\$username', username);
      print("TBR: Parsed data i33333333333333s");

      print(replacedUrl); // This will print the modified URL

      print(
          "TBR: Parsed data is 111111111111111111111111111111111111111111111111111111111111111111111111$one");
    } catch (e, stackTrace) {
      print("TBR: Error reading json: $e");
      print("TBR: $stackTrace");
    }
  }

  @override
  void initState() {
    super.initState();
    // _readJsonfunction();
     
getDeviceId();
    _readJson();
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

Future<void> showDatePickerDialog(String fieldId, BuildContext? context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context!,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(jsonString: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
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

void callNavigate() {

   Navigator.pushReplacement(
                    navigatorKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              jsonString: "resp.screens[cnt]"
                            )),
                  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

  Future<void> insertTransaction(String date, String mobileNumber, String package, String txid) async {


    TransactionDetails transaction = TransactionDetails(
      date: date,
      mobileNumber: mobileNumber,
      package: package,
      txid: txid,
    );

    int insertedId = await databaseHelper.insertTransaction(transaction);
    print('Inserted transaction ID: $insertedId');

  
  }
 Future<void> _showImageDialog() async {
    // Implement your dialog logic here
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Image Button Clicked'),
          content: Text('This is the dialog content.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
