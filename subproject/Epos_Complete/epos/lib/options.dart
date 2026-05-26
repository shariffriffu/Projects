
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/options/about_us.dart';
import 'package:untitled1/options/contact_us.dart';
import 'package:untitled1/options/help.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(
            height: 63,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 144, 203, 238),
              ),
              child: Icon(Icons.menu),
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
                                SystemNavigator.pop();

              },
            ),
          ),
        ],
      ),
    );
  }
}
