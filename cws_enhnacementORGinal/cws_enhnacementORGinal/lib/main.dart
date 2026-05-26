// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:async';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/DistributorsPage.dart';
import 'package:untitled1/QRcodescanner.dart';
import 'package:untitled1/error.dart';
import 'package:untitled1/grafChart.dart';
import 'package:untitled1/renderingPage.dart';
import 'package:untitled1/ussd.dart';
import 'package:untitled1/webview.dart';
import 'CustomWidget/json_drawer.dart';
import 'USSDResponsePage.dart';
import 'login_page.dart';
import 'response.dart';
import 'package:audioplayers/audioplayers.dart';
import 'voice.dart';

final navigatorKey = GlobalKey<NavigatorState>();
FocusNode myfocus = FocusNode();
String loginScreenJson = ""; // Define loginScreenJson variable
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
String totalSalesPerDealerScreenJson = "";
String totalSalesPerPosScreenJson = "";
String scannedScreenJson = "";
String UtiltyBillPaymentScreenJson = "";
String reportScreenJson = "";
String partnerServiceScreenJson = "";
String settingScreenJson = "";
String serviceCode = "369";

void main() {
  var registry = JsonWidgetRegistry.instance;
  registry.setValue("alert", true);
  registry.registerFunctions({
    'validateForm': ({args, required registry}) => () async {
          final username = registry.getValue('username');
          final password = registry.getValue('password');
          showCircularLoading();
          print('username: $username');
          print('password: $password');
          if (username == null ||
              username.isEmpty ||
              password == null ||
              password.isEmpty) {
            await playaudio("please_enter.mp3", 1);
          } else {
            String UssdCode =
                '#$serviceCode*41*$password*160124*0*0*0*00*14160844545*$username#';
            final ussdResponse = await CallUssd(UssdCode);
            print('USSD Response: ussdResponse');
            if (ussdResponse == "-1") {
              print('inside if loop');
              navigatorKey.currentState?.push(MaterialPageRoute(
                builder: (context) => DistributorPage(
                    jsonString: distributorScreenJson, jsonUrl: ''),
              ));
            } else {
              // Close the loading screen
              navigatorKey.currentState?.push(MaterialPageRoute(
                builder: (context) => LoginError(
                  message: ussdResponse,
                ),
              ));
            }
          }
        },

    'PartnerService': ({args, required registry}) => () async {
          print("inside PartnerService");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) => renderingPage(
                jsonString: partnerServiceScreenJson, jsonUrl: ''),
          ));
        },
    'DataBoosters': ({args, required registry}) => () async {
          print("inside DataBoosters");
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Alert'),
                content: Text('Option will be available soon....'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
    'BillPayment': ({args, required registry}) => () async {
          print("inside BillPayment");
            showDialog(
            context: navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Alert'),
                content: Text('Option will be available soon....'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },

    'Settings': ({args, required registry}) => () async {
          print("inside Settings");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) =>
                renderingPage(jsonString: settingScreenJson, jsonUrl: ''),
          ));
        },
    'UtiltyBillPayment': ({args, required registry}) => () async {
          print("inside UtiltyBillPayment");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) => renderingPage(
                jsonString: UtiltyBillPaymentScreenJson, jsonUrl: ''),
          ));
        },
    'TicketToFerry': ({args, required registry}) => () async {
          print("inside TicketToFerry");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) => renderingPage(
                jsonString: UtiltyBillPaymentScreenJson, jsonUrl: ''),
          ));
        },
    'BusPass': ({args, required registry}) => () async {
          print("inside Buspass");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) => renderingPage(
                jsonString: UtiltyBillPaymentScreenJson, jsonUrl: ''),
          ));
        },
    'QrScan': ({args, required registry}) => () async {
          print("inside Scan_function");
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => QRViewExample(),
            ),
          );
        },

    'Recharge_submit': ({args, required registry}) => () async {
          print("inside Recharge_submit");
          final mobilenumber = registry.getValue('mobile_number');
          final amount = registry.getValue('amount');
          final dealerpassword = registry.getValue('password');
          print("mobilenumber: $mobilenumber");
          print("amount: $amount");
          print("password: $dealerpassword");

          if (mobilenumber == null ||
              mobilenumber.isEmpty ||
              amount == null ||
              amount.isEmpty ||
              dealerpassword == null ||
              dealerpassword.isEmpty) {
            showAlert('Validation Error', 'All fields are required');
            await playaudio("please_enter.mp3", 1);
            return;
          } else {
            String ussdCode =
                '#$serviceCode*27*$dealerpassword*$mobilenumber*$amount*0*0*00*14160844545*0#';

            // Show loading indicator
            showCircularLoading();
            final ResponseForRecharge = await CallUssd(ussdCode);
            Navigator.of(navigatorKey.currentContext!).pop();
            Navigator.of(navigatorKey.currentContext!).pop();
            // Show alert dialog
            showAlertWithLoading('USSD Response', ResponseForRecharge);
          }
        },

    'Read_function': ({args, required registry}) => () async {
          print("inside Read_function");
          final mobilenumber = registry.getValue('mobile_number');
          final amount = registry.getValue('amount');
          if (mobilenumber == null ||
              mobilenumber.isEmpty ||
              amount == null ||
              amount.isEmpty) {
            await playaudio("please_enter.mp3", 1);
          } else {
            print('mobilenumber: $mobilenumber');
            await playaudio("Recharge_for_the_ mob.wav", 1);

            print('amount: $amount');
            await splitMobileNumber(mobilenumber);
            await playaudio("WIth_an_amount.wav", 1);

            await splitAndPlayAudio(amount);
            await playaudio("Rupies.wav", 1);
          }
        },
    'Reset_function': ({args, required registry}) => () async {
          print("inside Reset_function");
        },

    'Recharge_submitScan': ({args, required registry}) => () async {
          print("inside Recharge_submit");
          final mobilenumber = registry.getValue('Scanned_number');
          final amount = registry.getValue('amount');
          final dealerpassword = registry.getValue('password');
          print("mobilenumber: $mobilenumber");
          print("amount: $amount");
          print("password: $dealerpassword");

          if (mobilenumber == null ||
              mobilenumber.isEmpty ||
              amount == null ||
              amount.isEmpty ||
              dealerpassword == null ||
              dealerpassword.isEmpty) {
            await playaudio("please_enter.mp3", 1);

            showAlert('Validation Error', 'All fields are required');
            return;
          } else {
            String ussdCode =
                '*$serviceCode*7*0*27*$dealerpassword*$mobilenumber*$amount*0*0*00*860882068612183*2#';

            // Show loading indicator
            showCircularLoading();
            final ResponseForRecharge = await CallUssd(ussdCode);
            Navigator.of(navigatorKey.currentContext!)
                .pushReplacement(MaterialPageRoute(
                    builder: (context) => DistributorPage(
                          jsonString: distributorScreenJson,
                          jsonUrl: '',
                        )));
            ();

            // Show alert dialog
            showAlertWithLoading('USSD Response', ResponseForRecharge);
          }
        },

    'Read_functionScan': ({args, required registry}) => () async {
          print("inside Read_function");
          final mobilenumber = registry.getValue('Scanned_number');
          final amount = registry.getValue('amount');
          if (mobilenumber == null ||
              mobilenumber.isEmpty ||
              amount == null ||
              amount.isEmpty) {
            await playaudio("please_enter.mp3", 1);
          } else {
            print('mobilenumber: $mobilenumber');
            await playaudio("Recharge_for_the_ mob.wav", 1);

            print('amount: $amount');
            await splitMobileNumber(mobilenumber);
            await playaudio("WIth_an_amount.wav", 1);

            await splitAndPlayAudio(amount);
            await playaudio("Rupies.wav", 1);
          }
        },
    'Reset_functionScan': ({args, required registry}) => () async {
          print("inside Reset_function");
        },

    'Readfortransferfunction': ({args, required registry}) => () async {
          print("inside Read_function");
          final retailerNumber = registry.getValue('retailer_id');
          final amount = registry.getValue('Transfer_amount');
          if (retailerNumber == null ||
              retailerNumber.isEmpty ||
              amount == null ||
              amount.isEmpty) {
            await playaudio("please_enter.mp3", 1);
          } else {
            print('mobilenumber: $retailerNumber');
            await playaudio("Transfertomobile.wav", 1);

            print('amount: $amount');
            await splitMobileNumber(retailerNumber);
            await playaudio("WIth_an_amount.wav", 1);

            await splitAndPlayAudio(amount);
            await playaudio("Rupies.wav", 1);
          }
        },
    'Restfortransferfunction': ({args, required registry}) => () async {
          print("inside Reset_function");
        },

    'Transfer_submit': ({args, required registry}) => () async {
          print("inside Transfer_submit");
          final retailerId = registry.getValue('retailer_id');
          final transferAmount = registry.getValue('Transfer_amount');
          final dealerpassword = registry.getValue('password');
          print("mobilenumber: $retailerId");
          print("amount: $transferAmount");
          print("password: $dealerpassword");
          if (retailerId == null ||
              retailerId.isEmpty ||
              transferAmount == null ||
              transferAmount.isEmpty ||
              dealerpassword == null ||
              dealerpassword.isEmpty) {
            showAlert('Validation Error', 'All fields are required');
            await playaudio("please_enter.mp3", 1);
            return;
          } else {
            String ussdCode =
                '#$serviceCode*23*$dealerpassword*$retailerId*$transferAmount*0*0*00*14160844545*0#';
            // Show loading indicator
            showCircularLoading();
            final ResponseForRecharge = await CallUssd(ussdCode);
            Navigator.of(navigatorKey.currentContext!).pop();
            Navigator.of(navigatorKey.currentContext!).pop();
            // Show alert dialog
            showAlertWithLoading('USSD Response', ResponseForRecharge);
          }
        },

    'RetailerBalance_submit': ({args, required registry}) => () async {
          print("inside RetailerBalance_submit");
          final retailerId = registry.getValue('retailer_id');
          final dealerpassword = registry.getValue('password');
          print("mobilenumber: $retailerId");
          print("password: $dealerpassword");
          if (retailerId == null ||
              retailerId.isEmpty ||
              dealerpassword == null ||
              dealerpassword.isEmpty) {
            showAlert('Validation Error', 'All fields are required');
            await playaudio("please_enter.mp3", 1);

            return;
          } else {
            String ussdCode =
                '#$serviceCode*25*$dealerpassword*$retailerId*0*0*0*00*14160844545*0#';
            showCircularLoading();
            final ResponseForRetailerBalance = await CallUssd(ussdCode);
            Navigator.of(navigatorKey.currentContext!).pop();
            Navigator.of(navigatorKey.currentContext!).pop();
            // Show alert dialog
            showAlertWithLoading('USSD Response', ResponseForRetailerBalance);
          }
        },

    'AddRetailer_submit': ({args, required registry}) => () async {
          print("inside AddRetailer_submit");
          final retailerId = registry.getValue('Retailer_User_Id');
          final retailerPassword = registry.getValue('Retailer_Password');
          final dealerpassword = registry.getValue('password');

          print("mobilenumber: $retailerId");
          print("password: $retailerPassword");
          if (retailerId == null ||
              retailerId.isEmpty ||
              retailerPassword == null ||
              retailerPassword.isEmpty ||
              dealerpassword == null ||
              dealerpassword.isEmpty) {
            showAlert('Validation Error', 'All fields are required');
            await playaudio("please_enter.mp3", 1);

            return;
          } else {
            String ussdCode =
                '#$serviceCode*20*$dealerpassword*$retailerId*$retailerPassword*0*0*00*14160844545*0#';
            showCircularLoading();
            final ResponseForAddRetailer = await CallUssd(ussdCode);
            Navigator.of(navigatorKey.currentContext!).pop();
            Navigator.of(navigatorKey.currentContext!).pop();
            // Show alert dialog
            showAlertWithLoading('USSD Response', ResponseForAddRetailer);
          }
        },

    'DeleteRetailer_submit': ({args, required registry}) => () async {
          print("inside DeleteRetailer_submit");
          final retailerUserId = registry.getValue('Retailer_User_Id');
          final dealerpassword = registry.getValue('password');
          print("mobilenumber: $retailerUserId");
          print("password: $dealerpassword");

          if (retailerUserId == null ||
              retailerUserId.isEmpty ||
              dealerpassword == null ||
              dealerpassword.isEmpty) {
            showAlert('Validation Error', 'All fields are required');
            await playaudio("please_enter.mp3", 1);

            return;
          } else {
            String ussdCode =
                '#$serviceCode*21*$dealerpassword*$retailerUserId*0*0*0*00*14160844545*0#';

            // Show loading indicator
            showCircularLoading();
            final ResponseForDeleteRetailer = await CallUssd(ussdCode);
            Navigator.of(navigatorKey.currentContext!).pop();
            Navigator.of(navigatorKey.currentContext!).pop();

            // Show alert dialog
            showAlertWithLoading('USSD Response', ResponseForDeleteRetailer);
          }
        },

    'debit_Submit': ({args, required registry}) => () async {
          print("inside debit_Submit");
          final retailerUserId = registry.getValue('Retailer_User_Id');
          final amount = registry.getValue('amount');
          final dealerpassword = registry.getValue('password');
          print("mobilenumber: $retailerUserId");
          print("amount: $amount");
          print("password: $dealerpassword");

          if (retailerUserId == null ||
              retailerUserId.isEmpty ||
              amount == null ||
              amount.isEmpty ||
              dealerpassword == null ||
              dealerpassword.isEmpty) {
            showAlert('Validation Error', 'All fields are required');
            await playaudio("please_enter.mp3", 1);

            return;
          } else {
            String ussdCode =
                '#$serviceCode*21*$dealerpassword*$retailerUserId*0*0*0*00*14160844545*0#';

            // Show loading indicator
            showCircularLoading();
            final ResponseForDebit = await CallUssd(ussdCode);
            Navigator.of(navigatorKey.currentContext!).pop();
            Navigator.of(navigatorKey.currentContext!).pop();

            // Show alert dialog
            showAlertWithLoading('USSD Response', ResponseForDebit);
          }
        },
    'changeRetailerPassword_Submit': ({args, required registry}) => () async {
          print("inside changeRetailerPassword_Submit");
          final retailerUserId = registry.getValue('Retailer_User_Id');
          final NewPassword = registry.getValue('NewPassword');
          final dealerpassword = registry.getValue('password');
          print("mobilenumber: $retailerUserId");
          print("NewPassword: $NewPassword");
          print("password: $dealerpassword");

          if (retailerUserId == null ||
              retailerUserId.isEmpty ||
              NewPassword == null ||
              NewPassword.isEmpty ||
              dealerpassword == null ||
              dealerpassword.isEmpty) {
            showAlert('Validation Error', 'All fields are required');
            await playaudio("please_enter.mp3", 1);

            return;
          } else {
            String ussdCode =
                '#$serviceCode*21*$dealerpassword*$retailerUserId*0*0*0*00*14160844545*0#';

            // Show loading indicator
            showCircularLoading();
            final ResponseForDebit = await CallUssd(ussdCode);
            Navigator.of(navigatorKey.currentContext!).pop();
            Navigator.of(navigatorKey.currentContext!).pop();

            // Show alert dialog
            showAlertWithLoading('USSD Response', ResponseForDebit);
          }
        },

    //functions of the buttons

    'recharge': ({args, required registry}) => () async {
          print("inside Options_recharge");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) =>
                renderingPage(jsonString: rechargeScreenJson, jsonUrl: ''),
          ));
        },

    'Transfer': ({args, required registry}) => () async {
          print("inside Transfer");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) =>
                renderingPage(jsonString: transferScreenJson, jsonUrl: ''),
          ));
        },

    'Balance': ({args, required registry}) => () async {
          final ussdCode = '#$serviceCode*25*0*0*0*0*0*00*14160844545*0#';
          showCircularLoading();
          final ResponseForBalance = await CallUssd(ussdCode);
          // Dismiss loading indicator
          Navigator.of(navigatorKey.currentContext!).pop();
          // Show alert dialog
          showAlertWithLoading('USSD Response', ResponseForBalance);
          print("inside Balance");
        },

    'Retailer_Balance': ({args, required registry}) => () async {
          print("inside Retailer_Balance");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) => renderingPage(
                jsonString: retailerBalanceScreenJson, jsonUrl: ''),
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
                    final ussdCode =
                        '#$serviceCode*888*$enteredPassword*0*0*0*0*00*14160844545*0#';
                    showCircularLoading();
                    final ResponseForLastReqStatus = await CallUssd(ussdCode);
                    // Dismiss loading indicator
                    Navigator.of(navigatorKey.currentContext!).pop();
                    // Show alert dialog
                    showAlertWithLoading(
                        'USSD Response', ResponseForLastReqStatus);
                    // Do something with the entered password, e.g., validate or process it
                    print('Entered Password: $enteredPassword');
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          );
        },

    'Add_Retailer': ({args, required registry}) => () async {
          print("inside Add_Retailer");

          // Show alert dialog
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) =>
                renderingPage(jsonString: addRetailerScreenJson, jsonUrl: ''),
          ));
        },

    'View_Retailer': ({args, required registry}) => () async {
          print("inside View_Retailer");
          final ussdCode = '#$serviceCode*22*0*0*0*0*0*00*14160844545*0#';
          showCircularLoading();
          final ResponseForViewRetailer = await CallUssd(ussdCode);
          Navigator.of(navigatorKey.currentContext!).pop();
          showAlertWithLoading('USSD Response', ResponseForViewRetailer);
        },

    'Delete_Retailer': ({args, required registry}) => () async {
          print("inside Delete_Retailer");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) => renderingPage(
                jsonString: deleteRetailerScreenJson, jsonUrl: ''),
          ));
        },

    'Change_Retailer_password': ({args, required registry}) => () async {
          print("inside Change_Retailer_password");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) => renderingPage(
                jsonString: changeRetailerPasswordScreenJson, jsonUrl: ''),
          ));
        },

    'Debit': ({args, required registry}) => () async {
          print("inside Debit");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) =>
                renderingPage(jsonString: debitScreenJson, jsonUrl: ''),
          ));
        },

    'Reports': ({args, required registry}) => () async {
          print("inside Reports");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) =>
                renderingPage(jsonString: reportScreenJson, jsonUrl: ''),
          ));
        },
    'TotalSalePerDealer': ({args, required registry}) => () async {
          print("inside TotalSalePerDealer");
          //  navigatorKey.currentState?.push(MaterialPageRoute(
          //  builder: (context) => renderingPage(jsonString: totalSalesPerDealerScreenJson, jsonUrl: ''),
          //     ));

          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => ChartApp(),
            ),
          );
        },
    'TotalSalesPerDealer': ({args, required registry}) => () async {
          print("inside TotalSalesPerDealer");

          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => ChartApp(),
            ),
          );
        },

    'TotalSalePerPos': ({args, required registry}) => () async {
          print("inside TotalSalePerPos");
          //  navigatorKey.currentState?.push(MaterialPageRoute(
          //  builder: (context) => renderingPage(jsonString: totalSalesPerPosScreenJson, jsonUrl: ''),
          //     ));

          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => ChartApp(),
            ),
          );
        },
    'BalancePerDealer': ({args, required registry}) => () async {
          print("inside BalancePerDealer");
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
                    final ussdCode =
                        '#$serviceCode*888*$enteredPassword*0*0*0*0*00*14160844545*0#';
                    showCircularLoading();
                    final ResponseForLastReqStatus = await CallUssd(ussdCode);
                    // Dismiss loading indicator
                    Navigator.of(navigatorKey.currentContext!).pop();
                    // Show alert dialog
                    showAlertWithLoading(
                        'USSD Response', ResponseForLastReqStatus);
                    // Do something with the entered password, e.g., validate or process it
                    print('Entered Password: $enteredPassword');
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          );
        },

    'image': ({args, required registry}) => () async {
          print("inside image");
          Navigator.of(navigatorKey.currentContext!).push(
              MaterialPageRoute(builder: (context) => const WebviewPage()));
        },
    'Options_help': ({args, required registry}) => () async {
          print("inside Options_recharge");
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) =>
                renderingPage(jsonString: HelpOption, jsonUrl: ''),
          ));
        },

    'Options_aboutUs': ({args, required registry}) => () async {
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) =>
                renderingPage(jsonString: aboutUsOption, jsonUrl: ''),
          ));
        },

    'Options_contactUs': ({args, required registry}) => () async {
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) =>
                renderingPage(jsonString: contactUsOption, jsonUrl: ''),
          ));
        },

    'Options_logout': ({args, required registry}) => () async {
          print("inside logout");
          navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
            builder: (context) =>
                login_page(jsonString: loginScreenJson, jsonUrl: ''),
          ));
        }
  });

  registry.registerCustomBuilder(
      DrawerBuilder.kType,
      // from generate file
      JsonWidgetBuilderContainer(
        builder: (map, {registry}) =>
            DrawerBuilder.fromDynamic(map), // from generate file
      ));

  runApp(MyApp());
}

TextEditingController _numberController = TextEditingController();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

late AudioPlayer audioPlayer;

Map<String, dynamic> loginScreenData = {};
bool isLoading = true;

class _MyAppState extends State<MyApp> {
   late bool isFirstTime;

  @override
  void initState() {
    super.initState();
    checkFirstTime();
    callJson();
       _platform.setMethodCallHandler(_handleMethodCall);
    _checkDeviceType();
  }

  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      // Perform first-time setup or actions here
      // For example, show an introduction screen, set default preferences, etc.
      
      // Once first-time actions are performed, set isFirstTime to false
      await prefs.setBool('isFirstTime', false);
    }
  }


// Define retailerScreenJson variable
final MethodChannel _platform = const MethodChannel('com.cloudpos.convertdifffinger/convertdifffinger');
  final List<Text> _hints = [];
  final ScrollController _scrollController = ScrollController();

 Future<void> _checkDeviceType() async {
    final String result = await _platform.invokeMethod('checkDeviceType');
    _setHintMessage("deviceType is $result", 0);
  }

  void _setHintMessage(String hint, int code){
    Color textColor = Colors.black;
    if (code == 1) {
      textColor = Colors.blue;
    } else if (code == 2) {
      textColor = Colors.red;
    }
    setState(() {
      _hints.add(Text( hint,style: TextStyle(color: textColor)));
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _clickBtn(String message) {
    _setHintMessage("Please put your finger !", 0);
    _platform.invokeMethod('print', {'message': message});
  }

  void _clickadd() {
    _setHintMessage("Please put your finger !", 0);
    _platform.invokeMethod('add');
  }

  void _clickverify() {
    _setHintMessage("Please put your finger !", 0);
    _platform.invokeMethod('verify');
  }

  
  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getDataNomal':
      case 'getDataSuccess':
      case 'getDataFail':
        final int code = call.method == 'getDataSuccess' ? 1 : call.method == 'getDataFail' ? 2 : 0;
        _setHintMessage(call.arguments, code);
        break;
      default:
        throw MissingPluginException();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> callJson() async {
    final url = Uri.parse('http://10.0.6.101/fcgi-bin/androidEpos');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          Epos resp = eposFromJson(response.body);
          loginScreenJson = resp.login_screen;
          // loginScreenJson =resp.reports_screen;
          distributorScreenJson = resp.distributor_screen;
          rechargeScreenJson = resp.recharge_screen;
          transferScreenJson = resp.transfer_screen;
          retailerBalanceScreenJson = resp.retailerBalance_screen;
          addRetailerScreenJson = resp.addRetailer_screen;
          deleteRetailerScreenJson = resp.deleteRetailer_screen;
          debitScreenJson = resp.debit_screen;
          changeRetailerPasswordScreenJson = resp.changeRetailerPassword_screen;
          reportScreenJson = resp.reports_screen;
          totalSalesPerDealerScreenJson = resp.totalSalesPerDealer_screen;
          totalSalesPerPosScreenJson = resp.totalSalesPerPos_screen;
          HelpOption = resp.HelpOption;
          aboutUsOption = resp.aboutUsOption;
          contactUsOption = resp.contactUsOption;
          settingScreenJson = resp.setting_screen;
          partnerServiceScreenJson = resp.partnerService_screen;
          scannedScreenJson = resp.scanned_screen;
          UtiltyBillPaymentScreenJson = resp.utilityBillPayment_screen;

          print("settingScreenJson " + settingScreenJson);
          print("partnerServiceScreenJson " + partnerServiceScreenJson);
          print("Response_rechargescreen " + rechargeScreenJson);
          print("Response_retailer" + distributorScreenJson);
          print("Response_login" + loginScreenJson);
          print("Response_Help" + HelpOption);
          print("Response_UtiltyBillPaymentScreenJson" +
              UtiltyBillPaymentScreenJson);
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
          : login_page(
              jsonString: loginScreenJson,
              jsonUrl: '',
            ),
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
}

void showCircularLoading() {
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
  dismissCircularLoading();
  showAlert(title, message);
}
