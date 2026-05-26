import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pray_times/pray_times.dart';

void main() {
  runApp(Userpage());
}

class Userpage extends StatefulWidget {
  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  late String formattedDate;
  late String formattedTime;
  String? currentPrayer;
  String? nextPrayer;
  double? lastDonationAmount;
  DateTime? lastDonationDate;

  @override
  void initState() {
    super.initState();
    _getCurrentTime();
    _getPrayerTimes();
    _loadLastDonationDetails();
  }

  void _getCurrentTime() {
    final DateTime now = DateTime.now();
    formattedDate = DateFormat('dd MMMM yyyy').format(now);
    formattedTime = DateFormat('hh:mm:ss a').format(now);

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        formattedTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      });
    });
  }

  void _getPrayerTimes() {
    PrayerTimes prayers = PrayerTimes();
    prayers.setTimeFormat(PrayerTimes().Time24);
    prayers.setCalcMethod(PrayerTimes().MWL);
    prayers.setAsrJuristic(PrayerTimes().Shafii);
    prayers.setAdjustHighLats(PrayerTimes().AngleBased);

    double latitude = 12.9714;
    double longitude = 77.5946;
    double timezone = 5.5;

    final date = DateTime.now();
    List<String> prayerTimes = prayers.getPrayerTimes(date, latitude, longitude, timezone);
    List<String> prayerNames = prayers.getTimeNames();

    for (int i = 0; i < prayerTimes.length; i++) {
      String formattedTime = _convertTo12HourFormat(prayerTimes[i]);

      if (prayerNames[i] == 'Fajr') {
        setState(() {
          currentPrayer = formattedTime;
          nextPrayer = prayerNames.length > i + 1 ? _convertTo12HourFormat(prayerTimes[i + 1]) : null;
        });
        break;
      }
    }
  }

  void _loadLastDonationDetails() {
    // Simulated data for demonstration purposes, replace with actual data retrieval logic
    setState(() {
      lastDonationAmount = 50.0; // Replace with the actual last donation amount
      lastDonationDate = DateTime.now().subtract(Duration(days: 7)); // Replace with the actual last donation date
    });
  }

  String _convertTo12HourFormat(String time) {
    final DateTime parsedTime = DateFormat('HH:mm').parse(time);
    return DateFormat('h:mm a').format(parsedTime);
  }

  Widget buildDonationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Donation Section',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Display last donation details or perform any other action
                  print('Last Donation Details Clicked');
                },
                child: Text('Last Paid Details'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () async {
                  
                },
                child: Text('Donate'),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        if (lastDonationAmount != null && lastDonationDate != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Donation Details:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Amount: \$${lastDonationAmount!.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Date: ${DateFormat('dd MMMM yyyy').format(lastDonationDate!)}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Timings'),
        backgroundColor: Colors.green[700], // Set app bar color to green
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Option 1'),
              onTap: () {
                // Handle option 1
              },
            ),
            ListTile(
              title: Text('Option 2'),
              onTap: () {
                // Handle option 2
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16),
              child: Transform.translate(
                offset: Offset(0, -8),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                      shadows: [
                        Shadow(
                          color: Colors.black87,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$formattedDate $formattedTime',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildPrayerTiming('Current Prayer', currentPrayer),
                  if (nextPrayer != null) buildPrayerTiming('Next Prayer', nextPrayer),
                  Divider(), // Add a line after the next prayer
                ],
              ),
            ),
            buildDonationSection(),
          ],
        ),
      ),
    );
  }

  Widget buildPrayerTiming(String label, String? time) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Text(
            '$label: ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            time ?? 'None',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
