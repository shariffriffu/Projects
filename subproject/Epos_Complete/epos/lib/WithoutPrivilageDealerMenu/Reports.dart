// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/USSDResponsePage.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/Reports/BalanceperDealer.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/Reports/TotalSaleperDealer.dart';
import 'package:untitled1/WithoutPrivilageDealerMenu/Reports/TotalSalesperPOS.dart';
import 'package:untitled1/menu/WithoutPrivilageDealerMenu.dart';
import 'package:untitled1/ussd.dart';

void main() => runApp(const Reports());

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Reports';
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text(appTitle),
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WithoutPrivilageDealerMenu()),
            );
          },
          color: Color.fromARGB(255, 10, 5, 5),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0, // Set to 1.0 to make each button a square
              padding: const EdgeInsets.all(20),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                buildElevatedButton(
                  context,
                  'Total Sale per Dealer',
                  Icons.monetization_on,
                  const TotalSaleperDealer(),
                ),
                buildElevatedButton(
                  context,
                  'Total Sales per POS',
                  Icons.point_of_sale,
                  const TotalSalesperPOS(),
                ),
                buildElevatedButton(
                  context,
                  'Balance per Dealer',
                  Icons.account_balance,
                  const BalanceperDealer(),
                ),
              ],
            ),
          ),
        ],
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

 if (buttonText == 'Balance per Dealer') {
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