// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<_SalesData> data = [];
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.6.101/fcgi-bin/new?graf=graf'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        data = jsonData.map((item) => _SalesData(item['WMC_TRANS_TYPE'], int.parse(item['count']))).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter chart'),
      ),
      body: Column(
        children: [
          if (selectedTabIndex == 0)
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'Total Sales Count'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.WMC_TRANS_TYPE,
                  yValueMapper: (_SalesData sales, _) => sales.count,
                  name: 'Sales',
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                )
              ],
            ),
          if (selectedTabIndex == 1)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfSparkLineChart.custom(
                  trackball: SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
                  marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
                  labelDisplayMode: SparkChartLabelDisplayMode.all,
                  xValueMapper: (int index) => data[index].WMC_TRANS_TYPE,
                  yValueMapper: (int index) => data[index].count,
                  dataCount: data.length,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTabIndex,
        onTap: (index) {
          setState(() {
            selectedTabIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Chart View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Sparkline View',
          ),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.WMC_TRANS_TYPE, this.count);

  final String WMC_TRANS_TYPE;
  final int count;
}
