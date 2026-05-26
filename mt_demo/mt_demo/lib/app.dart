// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'B - Tunes',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BTunesScreen(),
    );
  }
}

class BTunesScreen extends StatefulWidget {
  @override
  _BTunesScreenState createState() => _BTunesScreenState();
}

class _BTunesScreenState extends State<BTunesScreen>
    with SingleTickerProviderStateMixin {
  bool isSubscribed = false;
  late TabController _tabController;
  bool switchValue = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = 225.0;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
          ),
          Container(
            height: appBarHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color.fromARGB(255, 0, 34, 85), Colors.green]),
            ),
            child: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => {},
              ),
              title: Center(
                child: Text(
                  'B - Tunes',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.help,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Positioned(
            top: appBarHeight - 80,
            left: 15,
            right: 15,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 228, 228, 228),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          "Subscribe to B-Tunes",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            value: switchValue,
                            onChanged: (value) {
                              setState(() {
                                switchValue = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.search_outlined)),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'Top Tunes'),
                      Tab(text: 'Latest Tunes'),
                      Tab(text: 'My Tunes'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        TunesList(),
                        Center(child: Text('Latest Tunes')),
                        Center(child: Text('My Tunes')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Action',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Audio',
          ),
        ],
        selectedItemColor: Colors.green,
      ),
    );
  }
}

class TunesList extends StatelessWidget {
  final List<Map<String, String>> tunes = [
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
    {'title': 'Dolma Chloe', 'id': '13996', 'price': 'NU 5'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tunes.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: index.isEven?const Color.fromARGB(115, 49, 255, 56): const Color.fromARGB(115, 156, 156, 156),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(8), right: Radius.circular(8))),
          child: ListTile(
            title: Text(
              tunes[index]['title']!,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text('ID: ${tunes[index]['id']}'),
            trailing: SizedBox(
              width: 180, // Adjust the width as needed
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Align the buttons to the end
                children: [
                  Text(
                    tunes[index]['price'].toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.play_arrow,
                        size: 30,
                      )),
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 61, 161, 68)),
                    onPressed: () {},
                    child: Text('Buy', style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}