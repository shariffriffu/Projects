import 'package:flutter/material.dart';
import 'package:ussd_and_login_page/main.dart';

import 'package:ussd_and_login_page/with_post_privilege_RMenu/My_PostPaid_Bal.dart';
import 'package:ussd_and_login_page/with_post_privilege_RMenu/balance.dart';
import 'package:ussd_and_login_page/with_post_privilege_RMenu/change_password.dart';
import 'package:ussd_and_login_page/with_post_privilege_RMenu/last_req_status.dart';
import 'package:ussd_and_login_page/with_post_privilege_RMenu/recharge.dart';

void main() => runApp(const Post_RMenu());

// ignore: camel_case_types
class Post_RMenu extends StatelessWidget {
  const Post_RMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Retailers menu For Postpaid Privilege';
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
                              builder: (context) => const Balance()),
                        );
                        print('Button 3 was pressed');
                      },
                      child: Text('My Balance'),
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
                              builder: (context) => const My_PostPaid_Bal()),
                        );
                        print('Button 3 was pressed');
                      },
                      child: Text('My PostPaid Bal'),
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
                ],
              ),
            ),
          ),
        ));
  }
}
