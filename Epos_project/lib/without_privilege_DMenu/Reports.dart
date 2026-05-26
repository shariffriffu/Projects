import 'package:flutter/material.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/Reports/BalanceperDealer.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/Reports/TotalSaleperDealer.dart';
import 'package:ussd_and_login_page/without_privilege_DMenu/Reports/TotalSalesperPOS.dart';
import 'package:ussd_and_login_page/Menu/post_distributers_menu.dart';

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
                MaterialPageRoute(builder: (context) => const DMenu()),
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
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              context,
              'Total Sale per Dealer',
              const TotalSaleperDealer(),
            ),
            const SizedBox(height: 16),
            _buildButton(
              context,
              'Total Sales per POS',
              const TotalSalesperPOS(),
            ),
            const SizedBox(height: 16),
            _buildButton(
              context,
              'Balance per Dealer',
              const BalanceperDealer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String title,
    Widget page,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          primary: Colors.blue,
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
