// ignore_for_file: non_constant_identifier_names, prefer_const_declarations

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:masjid_app/userpage.dart';
import 'package:pray_times/pray_times.dart';

import 'login.dart';

var Fajr = '';
var Sunrise = '';
var Dhuhr = '';
var Asr = '';
var Sunset ='';
var Maghrib = '';
var Isha = '';

void main() {
  runApp(MyApp());
double latitude = 12.9714;
double longitude = 77.5946;
double timezone = 5.5;

  PrayerTimes prayers = new PrayerTimes();
  prayers.setTimeFormat(prayers.Time24);
  prayers.setCalcMethod(prayers.MWL);
  prayers.setAsrJuristic(prayers.Shafii);
  prayers.setAdjustHighLats(prayers.AngleBased);
  var offsets = [0, 0, 0, 0, 0, 0, 0];
  prayers.tune(offsets);

  final date = DateTime(2023, DateTime.january, 20);
  List<String> prayerTimes =
  prayers.getPrayerTimes(date, latitude, longitude, timezone);
  List<String> prayerNames = prayers.getTimeNames();

  for (int i = 0; i < prayerTimes.length; i++) {
  print("${prayerNames[i]} - ${prayerTimes[i]}");
 String formattedTime = _convertTo12HourFormat(prayerTimes[i]);
  // Assigning names and timings to variables
   if (prayerNames[i] == 'Fajr') {
    Fajr = formattedTime;
    print("Fajr: $Fajr");
  } else if (prayerNames[i] == 'Dhuhr') {
    Dhuhr = formattedTime;
    print("Dhuhr: $Dhuhr");
  } else if (prayerNames[i] == 'Asr') {
    Asr = formattedTime;
    print("Asr: $Asr");
  } else if (prayerNames[i] == 'Maghrib') {
    Maghrib = formattedTime;
    print("Maghrib: $Maghrib");
  } else if (prayerNames[i] == 'Isha') {
    Isha = formattedTime;
    print("Isha: $Isha");
  }else if (prayerNames[i] == 'Sunrise') {
    Sunrise = formattedTime;
    print("Sunrise: $Sunrise");
  }else if (prayerNames[i] == 'Sunset') {
    Sunset = formattedTime;
    print("Sunset: $Sunset");
  }
}}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer Timings',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
    );
  }
}

class PrayerTimingsPage extends StatefulWidget {
  @override
  _PrayerTimingsPageState createState() => _PrayerTimingsPageState();
}

class _PrayerTimingsPageState extends State<PrayerTimingsPage> {
  late String formattedDate;
  late String formattedTime;
  String? currentPrayer;
  HijriCalendar _hijriDate = HijriCalendar.now();

  @override
  void initState() {
    super.initState();
    _getCurrentTime();
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

  void _showPrayerTimingDialog(String prayerName) {
    String azanTime = '';
    String namazTime = '';
    String lastTimeToPray = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(prayerName),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Azan Time: $azanTime'),
              Text('Namaz Time: $namazTime'),
              Text('Last Time to Pray: $lastTimeToPray'),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Timings'),
        actions: [
          ElevatedButton(
            child: Text('Login'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
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
                    'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
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
                    formattedDate,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 8),
                  Text(
                    formattedTime,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Hijri Date: ${_hijriDate.toFormat("MMMM dd, yyyy")}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Prayer Timings (Bangalore Time Zone)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  PrayerButton(
                    prayerName: 'Fajr',
                   
                    namazTime: Fajr,
                    onPressed: () {
                      _showPrayerTimingDialog('Fajr');
                    },
                  ),
                  PrayerButton(
                    prayerName: 'Zohar',
                    namazTime: Dhuhr,
                    onPressed: () {
                      _showPrayerTimingDialog('Zohar');
                    },
                  ),
                  PrayerButton(
                    prayerName: 'Asr',
                    namazTime: Asr,
                    onPressed: () {
                      _showPrayerTimingDialog('Asr');
                    },
                  ),
                  PrayerButton(
                    prayerName: 'Maghrib',
                    namazTime: Maghrib,
                    onPressed: () {
                      _showPrayerTimingDialog('Maghrib');
                    },
                  ),
                  PrayerButton(
                    prayerName: 'Isha',
                    namazTime: Isha,
                    onPressed: () {
                      _showPrayerTimingDialog('Isha');
                    },
                  ),
                   PrayerButton(
                    prayerName: 'Sunrise',
                    namazTime: Sunrise,
                    onPressed: () {
                      _showPrayerTimingDialog('Sunrise');
                    },
                  ),
                   PrayerButton(
                    prayerName: 'Sunset',
                    namazTime: Sunset,
                    onPressed: () {
                      _showPrayerTimingDialog('Sunset');
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Current Prayer: ${currentPrayer ?? 'None'}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrayerButton extends StatelessWidget {
  final String prayerName;
  final String namazTime;
  final VoidCallback onPressed;

  const PrayerButton({
    required this.prayerName,
    required this.namazTime,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all(EdgeInsets.all(0)), // Remove padding
          backgroundColor: MaterialStateProperty.all(
              Color.fromARGB(0, 8, 8, 8)), // Remove background color
        ),
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color.fromARGB(255, 20, 20, 20),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      prayerName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                   
                    Text(
                      'Namaz Time: $namazTime',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
String _convertTo12HourFormat(String time24) {
  final hourMinute = time24.split(':');
  final int hour24 = int.parse(hourMinute[0]);
  final int minute = int.parse(hourMinute[1]);

  String period = 'AM';
  int hour12 = hour24;

  if (hour12 >= 12) {
    period = 'PM';
    if (hour12 > 12) {
      hour12 -= 12;
    }
  }

  return '$hour12:${minute.toString().padLeft(2, '0')} $period';
}