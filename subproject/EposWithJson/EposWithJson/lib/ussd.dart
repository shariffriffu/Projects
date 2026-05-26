import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';
import 'package:ussd_service/ussd_service.dart';

Future<String> sendUssdRequest(String requestCode) async {
  String responseMessage;
  try {
    await Permission.phone.request();
    if (!await Permission.phone.isGranted) {
      throw Exception("Permission missing");
    }

    SimData simData = await SimDataPlugin.getSimData();
    responseMessage = await UssdService.makeRequest(
        simData.cards.first.subscriptionId, requestCode);

    List<String> responseLines = responseMessage.split('\n');
    for (String line in responseLines) {
      if (line.contains("Enter number")) {
        // Handle the valid input according to application needs
      } else if (line.contains("User canceled")) {
        // Handle the user cancellation
      }
      // And so on
    }

    int maxResponseLength = 5000;
    if (responseMessage.length > maxResponseLength) {
      responseMessage = "${responseMessage.substring(0, maxResponseLength)}...";
    }
  } on PlatformException catch (e) {
    responseMessage = e.message ?? '';
  }

  return responseMessage;
}
