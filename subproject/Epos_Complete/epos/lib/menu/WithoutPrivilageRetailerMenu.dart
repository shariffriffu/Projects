import 'package:untitled1/Giff.dart';
import 'package:untitled1/WithoutPrivilageRetailerMenu/balance.dart';
import 'package:untitled1/WithoutPrivilageRetailerMenu/change_password.dart';
import 'package:untitled1/WithoutPrivilageRetailerMenu/last_req_status.dart';
import 'package:untitled1/WithoutPrivilageRetailerMenu/recharge.dart';
import 'package:untitled1/options.dart';
import 'package:flutter/material.dart';

void main() => runApp(const WithoutPrivilageRetailerMenu());

class WithoutPrivilageRetailerMenu extends StatelessWidget {
  const WithoutPrivilageRetailerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Retailers menu';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(33, 150, 243, 1),
            textStyle: const TextStyle(fontSize: 20),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Retailers menu '),
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
                    Icons.receipt, // Add the icon for Recharge
                    const Recharge(),
                  ),
                  
                  buildElevatedButton(
                    context,
                    'My Balance',
                    Icons.account_balance_wallet, // Add the icon for My Balance
                    const Balance(),
                  ),
                  
                  buildElevatedButton(
                    context,
                    'Last Request Status',
                    Icons.access_time, // Add the icon for Last Request Status
                    const lastReqStat(),
                  ),
                  
                  
                  buildElevatedButton(
                    context,
                    'Change Password',
                    Icons.lock, // Add the icon for Change Password
                    const ChangePassword(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(
    BuildContext context,
    String buttonText,
    IconData iconData, // Added IconData parameter for the icon
    Widget destination,
  ) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
        print('Button $buttonText was pressed');
      },
      style: elevatedButtonStyleWithCenter(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 40), // Adjust the icon size as needed
          const SizedBox(height: 10),
          Text(buttonText),
        ],
      ),
    );
  }

  ButtonStyle elevatedButtonStyleWithCenter(
      {double fontSize = 17, double padding = 8}) {
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
 