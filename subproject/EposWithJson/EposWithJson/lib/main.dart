// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/DistributorsPage.dart';
import 'package:untitled1/error.dart';
import 'package:untitled1/options.dart';
import 'package:untitled1/pages/addRetailer.dart';
import 'package:untitled1/pages/changeRetailerPassword.dart';
import 'package:untitled1/pages/debit.dart';
import 'package:untitled1/pages/deleteRetailer.dart';
import 'package:untitled1/pages/retailerBalance.dart';
import 'package:untitled1/pages/transfer.dart';
import 'package:untitled1/reports.dart';
import 'package:untitled1/ussd.dart';
import 'CustomWidget/json_drawer.dart';
import 'USSDResponsePage.dart';
import 'login_page.dart';
import 'pages/recharge.dart';
import 'response.dart';

final navigatorKey = GlobalKey<NavigatorState>();
FocusNode myfocus = FocusNode();
  String loginScreenJson = "";  // Define loginScreenJson variable
  String distributorScreenJson = ""; 
  String HelpOption = "";
  String aboutUsOption = "";
  String contactUsOption = "";
  String rechargeScreenJson = "";
  String transferScreenJson = "";
  String retailerBalanceScreenJson = "";
  String addRetailerScreenJson = "";
  String deleteRetailerScreenJson = "";
  String debitScreenJson = "";
  String changeRetailerPasswordScreenJson = "";
  String reportScreenJson = "";
  String serviceCode = "369";
   

void main() {
   var registry = JsonWidgetRegistry.instance;
   registry.setValue("alert", true);
   registry.registerFunctions({
    
  'validateForm': ({args, required registry}) => () async{
      final username  = registry.getValue('username');
      final password = registry.getValue('password');
      showCircularLoading();
      print('username: $username');
      print('password: $password');
      String UssdCode ='#$serviceCode*41*$password*160124*0*0*0*00*14160844545*$username#';
      final ussdResponse = await CallUssd(UssdCode);
      print('USSD Response: ussdResponse');
      if (ussdResponse == "05") {
        print('inside if loop');
        navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => DistributorPage(jsonString: distributorScreenJson, jsonUrl: ''),
      ));
        }else {
          // Close the loading screen
          navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (context) => LoginError(message: ussdResponse,),
           ));
        } 
    },
    
  'Recharge_submit': ({args, required registry}) => () async {
   print("inside Recharge_submit");
   final mobilenumber = registry.getValue('mobile_number');
   final amount = registry.getValue('amount');
   final dealerpassword = registry.getValue('password');
   print("mobilenumber: $mobilenumber");
   print("amount: $amount");
   print("password: $dealerpassword");
   
   if (mobilenumber == null || mobilenumber.isEmpty ||
      amount == null || amount.isEmpty ||
      dealerpassword == null || dealerpassword.isEmpty) {
      showAlert('Validation Error', 'All fields are required');
      return;
    }
    String ussdCode ='#$serviceCode*27*$dealerpassword*$mobilenumber*$amount*0*0*00*14160844545*0#';

      // Show loading indicator
      showCircularLoading();
      final ResponseForRecharge = await CallUssd(ussdCode);
      Navigator.of(navigatorKey.currentContext!).pop();
      Navigator.of(navigatorKey.currentContext!).pop();
      // Show alert dialog
      showAlertWithLoading('USSD Response', ResponseForRecharge);
    },

  'Transfer_submit': ({args, required registry}) => () async {
    print("inside Transfer_submit");
    final retailerId = registry.getValue('retailer_id');
    final transferAmount = registry.getValue('Transfer_amount');
    final dealerpassword = registry.getValue('password');
    print("mobilenumber: $retailerId");
    print("amount: $transferAmount");
    print("password: $dealerpassword");
    if (retailerId == null || retailerId.isEmpty ||
      transferAmount == null || transferAmount.isEmpty ||
      dealerpassword == null || dealerpassword.isEmpty) {
    showAlert('Validation Error', 'All fields are required');
    return;
    }

    String ussdCode = '#$serviceCode*23*$dealerpassword*$retailerId*$transferAmount*0*0*00*14160844545*0#';
      // Show loading indicator
      showCircularLoading();
      final ResponseForRecharge = await CallUssd(ussdCode);
      Navigator.of(navigatorKey.currentContext!).pop();
      Navigator.of(navigatorKey.currentContext!).pop();
      // Show alert dialog
      showAlertWithLoading('USSD Response', ResponseForRecharge);
    },

  'RetailerBalance_submit': ({args, required registry}) => () async {
   print("inside RetailerBalance_submit");
   final retailerId = registry.getValue('retailer_id');
   final dealerpassword = registry.getValue('password');
   print("mobilenumber: $retailerId");
   print("password: $dealerpassword");
   if (retailerId == null || retailerId.isEmpty ||
      dealerpassword == null || dealerpassword.isEmpty) {
      showAlert('Validation Error', 'All fields are required');
      return;
  }
  
  String ussdCode ='#$serviceCode*25*$dealerpassword*$retailerId*0*0*0*00*14160844545*0#';
  showCircularLoading();
  final ResponseForRecharge = await CallUssd(ussdCode);
  Navigator.of(navigatorKey.currentContext!).pop();
  Navigator.of(navigatorKey.currentContext!).pop();
  // Show alert dialog
  showAlertWithLoading('USSD Response', ResponseForRecharge);
  },

  'AddRetailer_submit': ({args, required registry}) => () async {
   print("inside AddRetailer_submit");
   final retailerId = registry.getValue('Retailer_User_Id');
   final retailerPassword = registry.getValue('Retailer_Password');
   final dealerpassword = registry.getValue('password');

   print("mobilenumber: $retailerId");
   print("password: $retailerPassword");
   if (retailerId == null || retailerId.isEmpty ||
      retailerPassword == null || retailerPassword.isEmpty ||
      dealerpassword == null || dealerpassword.isEmpty) {
      showAlert('Validation Error', 'All fields are required');
      return;
  }
  
  String ussdCode ='#$serviceCode*20*$dealerpassword*$retailerId*$retailerPassword*0*0*00*14160844545*0#';
  showCircularLoading();
  final ResponseForAddRetailer = await CallUssd(ussdCode);
  Navigator.of(navigatorKey.currentContext!).pop();
  Navigator.of(navigatorKey.currentContext!).pop();
  // Show alert dialog
  showAlertWithLoading('USSD Response', ResponseForAddRetailer);
  },
  
   'DeleteRetailer_submit': ({args, required registry}) => () async {
   print("inside DeleteRetailer_submit");
   final retailerUserId = registry.getValue('Retailer_User_Id');
   final dealerpassword = registry.getValue('password');
   print("mobilenumber: $retailerUserId");
   print("password: $dealerpassword");
   
   if (retailerUserId == null || retailerUserId.isEmpty ||
      dealerpassword == null || dealerpassword.isEmpty) {
      showAlert('Validation Error', 'All fields are required');
      return;
    }
    String ussdCode ='#$serviceCode*21*$dealerpassword*$retailerUserId*0*0*0*00*14160844545*0#';

      // Show loading indicator
      showCircularLoading();
      final ResponseForDeleteRetailer = await CallUssd(ussdCode);
      Navigator.of(navigatorKey.currentContext!).pop();
            Navigator.of(navigatorKey.currentContext!).pop();

      // Show alert dialog
      showAlertWithLoading('USSD Response', ResponseForDeleteRetailer);
    },

    'debit_Submit': ({args, required registry}) => () async {
   print("inside debit_Submit");
   final retailerUserId = registry.getValue('Retailer_User_Id');
   final amount = registry.getValue('amount');
   final dealerpassword = registry.getValue('password');
   print("mobilenumber: $retailerUserId");
   print("amount: $amount");
   print("password: $dealerpassword");
   
   if (retailerUserId == null || retailerUserId.isEmpty ||
        amount == null || amount.isEmpty ||
      dealerpassword == null || dealerpassword.isEmpty) {
      showAlert('Validation Error', 'All fields are required');
      return;
    }
    String ussdCode ='#$serviceCode*21*$dealerpassword*$retailerUserId*0*0*0*00*14160844545*0#';

      // Show loading indicator
      showCircularLoading();
      final ResponseForDebit = await CallUssd(ussdCode);
      Navigator.of(navigatorKey.currentContext!).pop();
            Navigator.of(navigatorKey.currentContext!).pop();

      // Show alert dialog
      showAlertWithLoading('USSD Response', ResponseForDebit);
    },
      'changeRetailerPassword_Submit': ({args, required registry}) => () async {
   print("inside changeRetailerPassword_Submit");
   final retailerUserId = registry.getValue('Retailer_User_Id');
   final NewPassword = registry.getValue('NewPassword');
   final dealerpassword = registry.getValue('password');
   print("mobilenumber: $retailerUserId");
   print("NewPassword: $NewPassword");
   print("password: $dealerpassword");
   
   if (retailerUserId == null || retailerUserId.isEmpty ||
        NewPassword == null || NewPassword.isEmpty ||
      dealerpassword == null || dealerpassword.isEmpty) {
      showAlert('Validation Error', 'All fields are required');
      return;
    }
    String ussdCode ='#$serviceCode*21*$dealerpassword*$retailerUserId*0*0*0*00*14160844545*0#';

      // Show loading indicator
      showCircularLoading();
      final ResponseForDebit = await CallUssd(ussdCode);
      Navigator.of(navigatorKey.currentContext!).pop();
            Navigator.of(navigatorKey.currentContext!).pop();

      // Show alert dialog
      showAlertWithLoading('USSD Response', ResponseForDebit);
    },


  //functions of the buttons

  'recharge': ({args, required registry}) => () async{
   print("inside Options_recharge");
   navigatorKey.currentState?.push(MaterialPageRoute(
   builder: (context) => recharge(jsonString: rechargeScreenJson, jsonUrl: ''),
   )); 
   },
  
  'Transfer': ({args, required registry}) => () async{
   print("inside Transfer");
   navigatorKey.currentState?.push(MaterialPageRoute(
   builder: (context) => transfer(jsonString: transferScreenJson, jsonUrl: ''),
   ));
   },

  'Balance': ({args, required registry}) => () async{
   final ussdCode = '#$serviceCode*25*0*0*0*0*0*00*14160844545*0#';
   showCircularLoading();
   final ResponseForBalance = await CallUssd(ussdCode);
   // Dismiss loading indicator
   Navigator.of(navigatorKey.currentContext!).pop();
   // Show alert dialog
   showAlertWithLoading('USSD Response', ResponseForBalance);
   print("inside Balance");
  },
  
  'Retailer_Balance': ({args, required registry}) => () async{
   print("inside Retailer_Balance");
   navigatorKey.currentState?.push(MaterialPageRoute(
   builder: (context) => retailerBalance(jsonString: retailerBalanceScreenJson, jsonUrl: ''),
   )); 
   },
   
   'Last_Request': ({args, required registry}) => () async {
  print("inside Last_Request");
  TextEditingController passwordController = TextEditingController();
  await showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text('Enter Password'),
      content: TextField(
        controller: passwordController,
        obscureText: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Password',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            String enteredPassword = passwordController.text;
            Navigator.of(context).pop();
            final ussdCode = '#$serviceCode*888*$enteredPassword*0*0*0*0*00*14160844545*0#';
   showCircularLoading();
   final ResponseForLastReqStatus = await CallUssd(ussdCode);
   // Dismiss loading indicator
   Navigator.of(navigatorKey.currentContext!).pop();
   // Show alert dialog
   showAlertWithLoading('USSD Response', ResponseForLastReqStatus);
            // Do something with the entered password, e.g., validate or process it
            print('Entered Password: $enteredPassword');
          },
          child: Text('Submit'),
        ),
      ],
    ),
  );
},


    'Add_Retailer': ({args, required registry}) => () async{
     print("inside Add_Retailer");

     // Show alert dialog
    navigatorKey.currentState?.push(MaterialPageRoute(
   builder: (context) => addRetailer
   (jsonString: addRetailerScreenJson, jsonUrl: ''),
   )); 

    },

    'View_Retailer': ({args, required registry}) => () async{
     print("inside View_Retailer");
       final ussdCode = '#$serviceCode*22*0*0*0*0*0*00*14160844545*0#';
       showCircularLoading();
       final ResponseForViewRetailer = await CallUssd(ussdCode);
       Navigator.of(navigatorKey.currentContext!).pop();
       showAlertWithLoading('USSD Response', ResponseForViewRetailer);
    },
    
    'Delete_Retailer': ({args, required registry}) => () async{
     print("inside Delete_Retailer");
   navigatorKey.currentState?.push(MaterialPageRoute(
   builder: (context) => deleteRetailer(jsonString: deleteRetailerScreenJson, jsonUrl: ''),
   )); 
    },
    
    'Change_Retailer_password': ({args, required registry}) => () async{
     print("inside Change_Retailer_password");
       navigatorKey.currentState?.push(MaterialPageRoute(
   builder: (context) => changeRetailerPassword(jsonString: changeRetailerPasswordScreenJson, jsonUrl: ''),
      ));
    },
    
    'Debit': ({args, required registry}) => () async{
     print("inside Debit");
      navigatorKey.currentState?.push(MaterialPageRoute(
   builder: (context) => debit(jsonString: debitScreenJson, jsonUrl: ''),
      ));
    },
    
    'Reports': ({args, required registry}) => () async{
     print("inside Reports");
       navigatorKey.currentState?.push(MaterialPageRoute(
   builder: (context) => reports(jsonString: reportScreenJson, jsonUrl: ''),
      ));
    },
     'TotalSalePerDealer': ({args, required registry}) => () async{
   print("inside TotalSalePerDealer");
   
   },
    'TotalSalePerPos': ({args, required registry}) => () async{
   print("inside TotalSalePerPos");
   
   },
    'BalancePerDealer': ({args, required registry}) => () async{
   print("inside BalancePerDealer");
   
   },

    'Options_help': ({args, required registry}) => () async{
     print("inside Options_recharge");
     navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
     builder: (context) => optionsPage(jsonString: HelpOption, jsonUrl: ''),
     ));
     },

    'Options_aboutUs': ({args, required registry}) => () async{
     navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
     builder: (context) => optionsPage(jsonString: aboutUsOption, jsonUrl: ''),
     ));
     },

    'Options_contactUs': ({args, required registry}) => () async{
     navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
     builder: (context) => optionsPage(jsonString: contactUsOption, jsonUrl: ''),
    ));
    },

    'Options_logout': ({args, required registry}) => () async{
    }
    });
  
  registry.registerCustomBuilder(
  DrawerBuilder.kType,
  // from generate file
   JsonWidgetBuilderContainer(
       builder: (map, {registry}) => DrawerBuilder.fromDynamic(map), // from generate file
     ));
        
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
const MyApp({super.key});
 @override
 State<MyApp> createState() => _MyAppState();
}

Map<String, dynamic> loginScreenData = {};
bool isLoading = true;
class _MyAppState extends State<MyApp> {
// Define retailerScreenJson variable
Future<void> callJson() async {
final url = Uri.parse('http://10.0.6.101/fcgi-bin/androidEpos');
try {
  final response = await http.get(url);
  if (response.statusCode == 200) {
     setState(() {
     Epos resp = eposFromJson(response.body);
     loginScreenJson = resp.login_screen;
     distributorScreenJson =resp.distributor_screen;
     rechargeScreenJson =resp.recharge_screen;
     transferScreenJson =resp.transfer_screen;
     retailerBalanceScreenJson =resp.retailerBalance_screen;
     addRetailerScreenJson =resp.addRetailer_screen;
     deleteRetailerScreenJson =resp.deleteRetailer_screen;
     debitScreenJson =resp.debit_screen;
     changeRetailerPasswordScreenJson =resp.changeRetailerPassword_screen;
     reportScreenJson =resp.reports_screen;
     HelpOption = resp.HelpOption;
     aboutUsOption = resp.aboutUsOption;
     contactUsOption = resp.contactUsOption;

     print("Response_rechargescreen "+rechargeScreenJson);
     print("Response_retailer"+distributorScreenJson);
     print("Response_login"+loginScreenJson);
     print("Response_Help"+HelpOption);
     isLoading = false;
      });
    } else {
      throw Exception('Failed to fetch data');
          }
    } catch (e) {
    print('Error: $e');
    }
  }
  @override
  void initState() {
  super.initState();
  callJson();
 }
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  navigatorKey: navigatorKey,
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
  primarySwatch: Colors.lightBlue,
  ),
  home: isLoading
  ? Center(
  child: CircularProgressIndicator(),
  )
  : login_page(jsonString: loginScreenJson, jsonUrl: '',),
  );
}
}



CallUssd(ussdCode) async {

  final prefs = await SharedPreferences.getInstance();
  String defaultServiceCode = '369';
  String? serviceCode = prefs.getString('Service code');
  print('inside loginWithUssd function');

  if (serviceCode == null) {
    serviceCode = defaultServiceCode;
    await prefs.setString('Service code', defaultServiceCode);
  }

  if (ussdCode.isNotEmpty) {
    String ussdResponse = await sendUssdRequest(ussdCode);
    print(ussdResponse);
    

    return ussdResponse;
}
}void showCircularLoading() {
  // Show circular loading indicator
  showDialog(
    context: navigatorKey.currentContext!,
      barrierDismissible: false, 
    builder: (context) => Center(
      child: CircularProgressIndicator(),
    ),
  );
}

void dismissCircularLoading() {
  // Dismiss loading indicator
  Navigator.of(navigatorKey.currentContext!).pop();
}
void showAlert(String title, String message) {
  // Show alert dialog
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            // Dismiss alert dialog
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => USSDResponsePage(response: message),
              ),
            );
          },
          child: const Text('Print'),
        ),
      ],
    ),
  );
}
  
void showAlertWithLoading(String title, String message) async {
  showCircularLoading();
  // Simulate asynchronous operation
  // await Future.delayed(Duration(seconds: 2));
  dismissCircularLoading();
  showAlert(title, message);
}


