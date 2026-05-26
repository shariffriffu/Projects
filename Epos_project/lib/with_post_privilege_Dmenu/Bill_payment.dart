// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ussd_and_login_page/Menu/distributers_menu.dart';

import '../ussd.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() => runApp(const Billpayment());

class Billpayment extends StatelessWidget {
  const Billpayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Bill Payment';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PostDmenu()),
              );
            },
            color: Colors.white,
          ),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serviceNoController = TextEditingController();
    final accountNoController = TextEditingController();
    final amountController = TextEditingController();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 16),
            TextField(
              controller: serviceNoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Service Number ',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: accountNoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Account Number',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const Text('submit'),
              onPressed: () async {
                final serviceNo = serviceNoController.text;
                final accountNo = accountNoController.text;
                final amount = amountController;
                final username = usernameController.text;
                final password = passwordController.text;

                if (serviceNo.isEmpty ||
                    accountNo.isEmpty ||
                    username.isEmpty ||
                    password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all the fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                showDialog(
                  context: context,
                  barrierDismissible:
                      false, // prevent the user from dismissing the dialog
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                // Construct the USSD request string
                final prefs = await SharedPreferences.getInstance();
                final servicecode = prefs.getString('Service code') ?? '';
                final ussdCode =
                    '*$servicecode*7*$serviceNo*23*$password*$serviceNo*$accountNo*$amount*0*2*860882068612183*2#';
                print('USSD Code: $ussdCode');
                final response = await sendUssdRequest(ussdCode);
                print('USSD Response: $response');

                // Show theresponse message to the user
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('USSD Response'),
                      content: Text(response),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            // Print the response to PDF
                            await Printing.layoutPdf(
                                onLayout: (PdfPageFormat format) {
                              final pdf = pw.Document();
                              pdf.addPage(
                                pw.Page(
                                  build: (context) => pw.Center(
                                    child: pw.Column(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text(
                                          'USSD Response:',
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        pw.Text(response),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              return pdf.save();
                            });

                            // Close the USSD response dialog
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Save as PDF'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Close the USSD response dialog
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ]),
    );
  }
}
