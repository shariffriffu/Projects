import 'package:flutter/material.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/AddRetailers.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/ChangePassword.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/ChangeRetailerPassword.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/Debit.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/DeleteRetailers.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/Reports.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/ViewRetailer.dart';

import '../../main.dart';
import '../without_privilege_DMenu/Recharge.dart';
import '../without_privilege_DMenu/RetailerBal.dart';
import '../without_privilege_DMenu/Transfer.dart';
import '../without_privilege_DMenu/lastReqStat.dart';
import '../without_privilege_DMenu/mybalance.dart';

class DMenu extends StatelessWidget {
  const DMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Distributers menu for Postpaid Privilege';
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
                MaterialPageRoute(builder: (context) => const MyApp()),
              );
            },
            color: Colors.white,
          ),
        ),
        body: const MyCustomForm(),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Recharge()),
                        );
                        // ignore: avoid_print
                        print('Button 1 was pressed');
                      },
                      child: const Text('Recharge'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Transfer()),
                        );
                        print('Button 2 was pressed');
                      },
                      child: Text('Transfer'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Balance()),
                        );
                        print('Button 3 was pressed');
                      },
                      child: Text('My Balance'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RetailerBal()),
                        );
                        print('Button 4 was pressed');
                      },
                      child: Text('Retailer Balance'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const lastReqStat()),
                        );
                        print('Button 5 was pressed');
                      },
                      child: Text('Last Req Status'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddRetailers()),
                        );
                        print('Button 6 was pressed');
                      },
                      child: Text('Add Retailers.'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button 7 was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewRetailer()),
                        );
                      },
                      child: Text('View Retailer'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button 8 was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DeleteRetailers()),
                        );
                      },
                      child: Text('Delete Retailer'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button 9 was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ChangeRetailerPassword()),
                        );
                      },
                      child: Text('Change Retailer Password'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button 10 was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangePassword()),
                        );
                      },
                      child: Text('Change Password'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button 11 was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Debit()),
                        );
                      },
                      child: Text('Debit'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button 12 was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Reports()),
                        );
                      },
                      child: Text('Reports'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
