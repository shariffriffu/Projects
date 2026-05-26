
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart'; 

class forgotPassOtp extends StatefulWidget {
  final String jsonString;
  const forgotPassOtp({Key? key, required this.jsonString}) : super(key: key);

  @override
  _forgotPassOtpState createState() => _forgotPassOtpState();
}


class _forgotPassOtpState extends State<forgotPassOtp>
    with SingleTickerProviderStateMixin {
  Map<dynamic, dynamic> mapData = {};
  var registry = JsonWidgetRegistry.instance;

  Future<void> _readJson() async {
    final String response =
        await rootBundle.loadString('lib/assets/forgotPassOtpVerify.json');
    final data = json.decode(response);
    setState(() {
      mapData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    registry.setValue('textFieldDecoration', InputBorder.none);
    TabController tabController = TabController(length: 3, vsync: this);
    registry.setValue('tabBarController', tabController);
    final topTunesList = [
      //{"TUNEID": "13996","TUNENAME": "Dolma Choeyang","TUNEURL":"http://202.144.156.178:8090/prbt/contentUpload/preview/13996.wav","TUNECOST":"5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "song 2", "id": "ID: 13423", "price": "NU 5"},
      {"title": "song3", "id": "ID: 13906", "price": "NU 95"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"}
    ];

    final latestTunesList = [
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "song 2", "id": "ID: 13423", "price": "NU 5"},
      {"title": "song3", "id": "ID: 13906", "price": "NU 95"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"}
    ];

    final myTunesList = [
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "song 2", "id": "ID: 13423", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"},
      {"title": "Dolma Chloe", "id": "ID: 13996", "price": "NU 5"}
    ];

    registry.setValue("topTunesList", topTunesList);
    registry.setValue("latestTunesList", latestTunesList);
    registry.setValue("myTunesList", myTunesList);
    _readJson();
  }

  @override
  Widget build(BuildContext context) {
    if (mapData.isEmpty) {
      return CircularProgressIndicator();
    } else {
      var widget = JsonWidgetData.fromDynamic(mapData, registry: registry);
      return widget.build(context: context);
    }
  }
}


            