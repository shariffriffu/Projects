import 'package:flutter/material.dart';
import 'package:ussd_and_login_page/Menu/distributers_menu.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/Reports/BalanceperDealer.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/Reports/TotalSaleperDealer.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/Reports/TotalSalesperPOS.dart';

void main() => runApp(const Reports());

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Distributers menu';
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
                              builder: (context) => const TotalSaleperDealer()),
                        );
                        // ignore: avoid_print
                        print('Button 1 was pressed');
                      },
                      child: const Text('Total Sale per Dealer'),
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
                              builder: (context) => const TotalSalesperPOS()),
                        );
                        print('Button 2 was pressed');
                      },
                      child: Text('Total Sales per POS'),
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
                              builder: (context) => const BalanceperDealer()),
                        );
                        print('Button 3 was pressed');
                      },
                      child: Text('Balance per Dealer'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
