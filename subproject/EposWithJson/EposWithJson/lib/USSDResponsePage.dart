import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class USSDResponsePage extends StatelessWidget {
  final String response;

   USSDResponsePage({Key? key, required this.response}) : super(key: key);

  static final PRINTER_PLATFORM_SPECIFIC_CODE = "com.shine.business/print_wizar_pos";
  static var platform = MethodChannel(PRINTER_PLATFORM_SPECIFIC_CODE);

  final FlutterTts flutterTts = FlutterTts();

  Future<void> _printWizarPOS(String formattedResponse) async {
    try {
      await platform.invokeMethod('printWizarPOS', formattedResponse);
      await flutterTts.speak(formattedResponse);
    } on PlatformException catch (e) {
      print("Failed to Print with Wizar POS : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Response'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Response:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(response),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // Format the response for printing and TTS
                final formattedResponse = '''
                  TAYANA SOFTWARE
                  $response
                  *********
                  Thank you
                ''';

                await _printWizarPOS(formattedResponse);
              },
              child: const Text('Print and Speak'),
            ),
          ],
        ),
      ),
    );
  }
}
