// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:untitled1/Giff.dart';
import 'package:untitled1/USSDResponsePage.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/AddRetailers.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/ChangeRetailerPassword.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/Debit.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/DeleteRetailers.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/Recharge.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/Reports.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/RetailerBal.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/Transfer.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/ViewRetailer.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/lastReqStat.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/mybalance.dart';
import 'package:untitled1/options.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/ussd.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';


void main() => runApp(const WithoutPrivilageDealerMenu());

class WithoutPrivilageDealerMenu extends StatelessWidget {
  const WithoutPrivilageDealerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Distributors Menu';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            textStyle: const TextStyle(fontSize: 20),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
     progressDialog = ProgressDialog(context);
    return WillPopScope(
      onWillPop: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        int backPressCount = prefs.getInt('backPressCount') ?? 0;

        if (backPressCount < 2) {
          backPressCount++;
          prefs.setInt('backPressCount', backPressCount);

          // Show a message indicating one more press is needed
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                color: Colors.black,
                height: 40, // Adjust the height as needed
                child: Center(
                  child: Text(
                    'Press again to exit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              duration: Duration(seconds: 2),
            ),
          );

          return Future.value(false);
        } else {
          // Reset backPressCount for future use
          prefs.setInt('backPressCount', 0);

          final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Exit Confirmation'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Are you sure you want to exit?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'No',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Yes, Exit',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );

          return value ?? false;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Distributors Menu'),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              );
            },
          ),
        ),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 350,
                height: 250,
                child: AnimatedGifWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    buildElevatedButton(
                      context,
                      'Recharge',
                      Icons.receipt,
                      const Recharge(),
                    ),
                    buildElevatedButton(
                      context,
                      'Transfer',
                      Icons.swap_horizontal_circle,
                      const Transfer(),
                    ),
                    buildElevatedButton(
                      context,
                      'My Balance',
                      Icons.account_balance_wallet,
                      const Balance(),
                    ),
                    buildElevatedButton(
                      context,
                      'Retailer Balance',
                      Icons.account_balance,
                      const RetailerBal(),
                    ),
                    buildElevatedButton(
                      context,
                      'Last Request Status',
                      Icons.access_time,
                      const lastReqStat(),
                    ),
                    buildElevatedButton(
                      context,
                      'Add Retailer',
                      Icons.person_add,
                      const AddRetailers(),
                    ),
                    buildElevatedButton(
                      context,
                      'View Retailer',
                      Icons.visibility,
                      const ViewRetailer(),
                    ),
                    buildElevatedButton(
                      context,
                      'Delete Retailers',
                      Icons.delete,
                      const DeleteRetailers(),
                    ),
                    buildElevatedButton(
                      context,
                      'Change Retailer Password',
                      Icons.lock,
                      const ChangeRetailerPassword(),
                    ),
                    buildElevatedButton(
                      context,
                      'Debit',
                      Icons.money_off,
                      const Debit(),
                    ),
                    buildElevatedButton(
                      context,
                      'Reports',
                      Icons.bar_chart,
                      const Reports(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  ElevatedButton buildElevatedButton(
  BuildContext context,
  String buttonText,
  IconData iconData,
  Widget destination,
) {
  return ElevatedButton(
    onPressed: () async {
      final prefs = await SharedPreferences.getInstance();
      final servicecode = prefs.getString('Service code') ?? '';

      if (buttonText == 'My Balance') {
        ProgressDialog progressDialog = ProgressDialog(context);
        progressDialog.style(
          message: 'Please wait...',
          borderRadius: 10.0,
          backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 0.0,
          maxProgress: 100.0,
          progressTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
          ),
          messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 19.0,
            fontWeight: FontWeight.w600,
          ),
        );

        try {
          // Show the progress dialog
          progressDialog.show();

          // Construct the USSD request string
          final ussdCode = '*$servicecode*7*0*25*0*0*0*0*0*2*860882068612183*0#';

          print('USSD Code: $ussdCode');
          final response = await sendUssdRequest(ussdCode);
          print('USSD Response: $response');

          // Hide the progress dialog
          progressDialog.hide();
          // Show the response message to the user
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('USSD Response'),
                content: Text(response),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Close the USSD response dialog
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => USSDResponsePage(response: response),
                        ),
                      );
                    },
                    child: const Text('Print'),
                  ),
                ],
              );
            },
          );
        } catch (error) {
          print('Error during USSD request: $error');
          // Handle error if needed
          // Hide the progress dialog
          progressDialog.hide();
        }
      } 
    else if (buttonText == 'View Retailer') {
        ProgressDialog progressDialog = ProgressDialog(context);
        progressDialog.style(
          message: 'Please wait...',
          borderRadius: 10.0,
          backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 0.0,
          maxProgress: 100.0,
          progressTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
          ),
          messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 19.0,
            fontWeight: FontWeight.w600,
          ),
        );

        try {
          // Show the progress dialog
          progressDialog.show();

          // Construct the USSD request string
          final ussdCode ='*$servicecode*7*22*0*0*0*0*0*0*0*860882068612183*0#';

          print('USSD Code: $ussdCode');
          final response = await sendUssdRequest(ussdCode);
          print('USSD Response: $response');

          // Hide the progress dialog
          progressDialog.hide();
          // Show the response message to the user
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('USSD Response'),
                content: Text(response),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Close the USSD response dialog
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => USSDResponsePage(response: response),
                        ),
                      );
                    },
                    child: const Text('Print'),
                  ),
                ],
              );
            },
          );
        } catch (error) {
          print('Error during USSD request: $error');
          // Handle error if needed
          // Hide the progress dialog
          progressDialog.hide();
        }
      }
else if (buttonText == 'Last Request Status') {
        // Show password input dialog
        final passwordController = TextEditingController();
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Enter Password'),
              content: TextField(
                controller: passwordController,
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close Password Input dialog
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final password = passwordController.text;
                    if (password.isNotEmpty) {
                      ProgressDialog progressDialog = ProgressDialog(context);
                      progressDialog.style(
                        
                        message: 'Please wait...',
                        borderRadius: 10.0,
                        backgroundColor: Colors.white,
                        progressWidget: CircularProgressIndicator(),
                        elevation: 10.0,
                        insetAnimCurve: Curves.easeInOut,
                        progress: 0.0,
                        maxProgress: 100.0,
                        progressTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                        messageTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w600,
                        ),
                      );

                      try {
                        // Show the progress dialog
                        progressDialog.show();

                        final ussdCode =
                            '*$servicecode*7*$password*888*0*0*0*0*0*0*0*860882068612183*0#';

                        print('USSD Code: $ussdCode');
                        final response = await sendUssdRequest(ussdCode);
                        print('USSD Response: $response');

                        // Hide the progress dialog
                        progressDialog.hide();

                        // Close the password input dialog if it's open
                        Navigator.of(context).pop();

                        // Show the response message to the user
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('USSD Response'),
                              content: Text(response),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Close the USSD response dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            USSDResponsePage(response: response),
                                      ),
                                    );
                                  },
                                  child: const Text('Print'),
                                ),
                              ],
                            );
                          },
                        );
                      } catch (error) {
                        print('Error during USSD request: $error');
                        // Handle error if needed
                        // Hide the progress dialog
                        progressDialog.hide();
                      }
                    } else {
                      // Handle case where password is empty
                      // You can show an error message or take other actions
                      print('Password cannot be empty');

                      // Hide the progress dialog
                      progressDialog.hide();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      } else {
        // For other buttons, navigate to the specified destination
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      }

      print('Button $buttonText was pressed');
    },
    style: elevatedButtonStyleWithCenter(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, size: 40),
        const SizedBox(height: 10),
        Text(buttonText),
      ],
    ),
  );
}


ButtonStyle elevatedButtonStyleWithCenter({double fontSize = 17, double padding = 8}) {
  return ElevatedButton.styleFrom(
    primary: Colors.blue,
    textStyle: TextStyle(fontSize: fontSize),
    padding: EdgeInsets.all(padding),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}
}