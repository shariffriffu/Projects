import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ussd_and_login_page/options/about_us.dart';
import 'package:ussd_and_login_page/options/contact_us.dart';
import 'package:ussd_and_login_page/options/help.dart';
import 'package:ussd_and_login_page/with_post_privilege_Dmenu/Bill_payment.dart';
import 'package:ussd_and_login_page/with_post_privilege_Dmenu/ChangeRetailerPassword.dart';
import 'package:ussd_and_login_page/with_post_privilege_Dmenu/My_Postpaid_balance.dart';
import 'package:ussd_and_login_page/with_post_privilege_Dmenu/PO_debit.dart';
import 'package:ussd_and_login_page/with_post_privilege_Dmenu/PO_transfer.dart';
import 'package:ussd_and_login_page/with_post_privilege_Dmenu/Recharge.dart';

import '../main.dart';
import '../with_post_privilege_Dmenu/AddRetailers.dart';

import '../with_post_privilege_Dmenu/Debit.dart';
import '../with_post_privilege_Dmenu/DeleteRetailers.dart';
import '../with_post_privilege_Dmenu/Reports.dart';
import '../with_post_privilege_Dmenu/RetailerBal.dart';
import '../with_post_privilege_Dmenu/Transfer.dart';
import '../with_post_privilege_Dmenu/ViewRetailer.dart';
import '../with_post_privilege_Dmenu/lastReqStat.dart';
import '../with_post_privilege_Dmenu/mybalance.dart';

void main() => runApp(const PostDmenu());

class PostDmenu extends StatelessWidget {
  const PostDmenu({Key? key}) : super(key: key);

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
  bool _showFullScreenGif = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 5), () {
      setState(() {
        _showFullScreenGif = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Distributors Menu'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 63,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 144, 203, 238),
                ),
                child: Text('Epos'),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Help and info'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HelpInfo(url: 'http://106.51.72.98/help.cgi')),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: ListTile(
                leading: const Icon(Icons.contact_phone),
                title: const Text('Contact us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactUs(
                            url: 'http://106.51.72.98/testagent.cgi')),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutUs(
                              url: 'http://106.51.72.98/aboutUs.cgi',
                            )),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('logout'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  padding: const EdgeInsets.all(20),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Recharge()),
                        );
                        print('Button recharge was pressed');
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Recharge'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Billpayment()),
                        );
                        print('Button Bill payment was pressed');
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Bill Payment'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Transfer()),
                        );
                        print('Button Transfer was pressed');
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Transfer'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PO_Transfer()),
                        );
                        print('Button PO_Transfer was pressed');
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Postpaid Transfer'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Balance()),
                        );
                        print('Button Balance was pressed');
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('My Balance'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Post_Balance()),
                        );
                        print('Button 6 was pressed');
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Postpaid Balance'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Button RetailerBal was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RetailerBal()),
                        );
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Retailer Balance'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Button lastReqStat was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const lastReqStat()),
                        );
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Last Request Status'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Button AddRetailers was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddRetailers()),
                        );
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text(' Add Retailer '),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Button ViewRetailer was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewRetailer()),
                        );
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('View Retailer'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Button DeleteRetailers was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DeleteRetailers()),
                        );
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Delete Retailers'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Button ChangeRetailerPassword was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ChangeRetailerPassword()),
                        );
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Change Retailer Password'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Button Debit was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Debit()),
                        );
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Debit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Button PO_Debit was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PO_Debit()),
                        );
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Postpaid Debit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Button Reports was pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Reports()),
                        );
                      },
                      style: elevatedButtonStyleWithCenter(),
                      child: const Text('Reports'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 350,
                height: 250,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 350,
                    width: 350,
                    child: Image.network(
                      'http://support.tayanasoftware.com/images/SELFCARE.gif',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showFullScreenGif)
            GestureDetector(
              onTap: () {
                setState(() {
                  _showFullScreenGif = false;
                  _startTimer();
                });
              },
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      'http://support.tayanasoftware.com/images/SELFCARE.gif',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  ButtonStyle elevatedButtonStyleWithCenter({double fontSize = 15}) {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      textStyle: TextStyle(fontSize: fontSize),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
