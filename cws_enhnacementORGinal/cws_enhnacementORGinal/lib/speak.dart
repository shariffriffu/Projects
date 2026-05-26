import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NumberSplitter(),
    ),
  );
}

class NumberSplitter extends StatefulWidget {
  const NumberSplitter({Key? key}) : super(key: key);

  @override
  State<NumberSplitter> createState() => _NumberSplitterState();
}

class _NumberSplitterState extends State<NumberSplitter> {
  TextEditingController _numberController = TextEditingController();
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Splitter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter a number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await splitAndPlayAudio(NumberSplitter);
              },
              child: Text('Split and Print'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> splitAndPlayAudio(Number) async {
    String inputNumber = _numberController.text.trim();
    if (inputNumber.isNotEmpty && int.tryParse(inputNumber) != null) {
      int number = int.parse(inputNumber);

      // Split the number into thousands, hundreds, tens, and ones
      int thousands = (number / 1000).truncate();
      int hundreds = ((number % 1000) / 100).truncate();
      int tens = ((number % 100) / 10).truncate();
      int ones = number % 10;

      // Convert each part to words
      String thousandsInWords = _convertToWords(thousands);
      String hundredsInWords = _convertToWords(hundreds);
      String tensInWords = _convertToWords(tens);
      String onesInWords = _convertToWords(ones);

      // Print the words
      print('Thousands: $thousandsInWords');
      print('Hundreds: $hundredsInWords');
      print('Tens: $tensInWords');
      print('Ones: $onesInWords');

      String thousandsRupee = '$thousandsInWords.wav';
      String hundredsRupee = '$hundredsInWords.wav';
      String tensRupee = '$tensInWords.wav';
      String onesRupee = '$onesInWords.wav';

      print("in thousands: $thousandsRupee");
      print("in hundred: $hundredsRupee");
      print("in tens: $tensRupee");
      print("in ones: $onesRupee");

      // You can call the playaudio function here if needed
      if (thousandsRupee != "Zero.wav") {
        print("inside thousand");
        await playaudio(thousandsRupee, 1);
        await playaudio("thousand.wav", 1);
      }

      if (hundredsRupee != "Zero.wav") {
        print("inside hundred");
        await playaudio(hundredsRupee, 1);
        await playaudio("hundred.wav", 1);
      }

      if (tensRupee != "Zero.wav") {
        print("inside tens");
        if (tensRupee == "One.wav") {
          print("inside ==================================");
          String digits = "$tensRupee$onesRupee";
          print("digits==================$digits");
          String result = replaceOneWithTen(digits);
          print("result=====$result");
          await playaudio(result, 1);
          return;
        }
        String value = replaceOneWithTen(tensRupee);

        print("the value after tens is $value");
        print(value);
        await playaudio(value, 1);
      }

      if (onesRupee != "Zero.wav") {
        print("inside ones");
        await playaudio(onesRupee, 1);
      }
    } else {
      // Show an error or handle invalid input
      print('Invalid input. Please enter a valid number.');
    }
  }

  String _convertToWords(int number) {
    if (number == 0) {
      return 'Zero';
    }

    const List<String> units = ['', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine'];
    const List<String> teens = ['Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'];
    const List<String> tens = ['', 'Ten', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'];

    String words = '';

    if (number >= 100) {
      words += '${units[number ~/ 100]} Hundred ';
      number %= 100;
    }

    if (number > 10 && number < 20) {
      words += '${teens[number - 11]} ';
    } else {
      words += '${tens[number ~/ 10]} ';
      number %= 10;
      words += '${units[number]} ';
    }

    return words.trim();
  }

  String replaceOneWithTen(String input) {
    print("inside replace $input");
    final Map<String, String> replacements = {
      "one.wav": "Ten.wav",
      "two.wav": "Twenty.wav",
      "three.wav": "Thirty.wav",
      "four.wav": "Forty.wav",
      "five.wav": "Fifty.wav",
      "six.wav": "Sixty.wav",
      "seven.wav": "Seventy.wav",
      "eight.wav": "Eighty.wav",
      "nine.wav": "Ninety.wav",
      "One.wav": "Ten.wav",
      "Two.wav": "Twenty.wav",
      "Three.wav": "Thirty.wav",
      "Four.wav": "Forty.wav",
      "Five.wav": "Fifty.wav",
      "Six.wav": "Sixty.wav",
      "Seven.wav": "Seventy.wav",
      "Eight.wav": "Eighty.wav",
      "Nine.wav": "Ninety.wav",
      "One.wavOne.wav": "Eleven.wav",
      "One.wavTwo.wav": "Twelve.wav",
      "One.wavThree.wav": "Thirteen.wav",
      "One.wavFour.wav": "Fourteen.wav",
      "One.wavFive.wav": "Fifteen.wav",
      "One.wavSix.wav": "Sixteen.wav",
      "One.wavSeven.wav": "Seventeen.wav",
      "One.wavEight.wav": "Eighteen.wav",
      "One.wavNine.wav": "Nineteen.wav",
      "One.wavZero.wav": "Ten.wav",
    };

    return replacements[input] ?? input;
  }

  Future<void> playaudio(String audio, int sec) async {
    print("Inside playaudio: $audio");
    return Future.delayed(Duration(seconds: sec), () {
      _audioPlayer.play(AssetSource(audio));
    });
  }
}




Future<void> splitMobileNumber(String inputNumber) async{
  try {
    print("inside splitMobileNumber"+inputNumber);
    int number = int.parse(inputNumber);

    if (number >= 1000000000 && number <= 9999999999) {
      // Extract individual digits
      int digit1 = (number ~/ 1000000000) % 10;
      int digit2 = (number ~/ 100000000) % 10;
      int digit3 = (number ~/ 10000000) % 10;
      int digit4 = (number ~/ 1000000) % 10;
      int digit5 = (number ~/ 100000) % 10;
      int digit6 = (number ~/ 10000) % 10;
      int digit7 = (number ~/ 1000) % 10;
      int digit8 = (number ~/ 100) % 10;
      int digit9 = (number ~/ 10) % 10;
      int digit10 = number % 10;

      // You can use digit1, digit2, ..., digit10 as needed
      print('Digit 1: $digit1');
      print('Digit 2: $digit2');
      print('Digit 3: $digit3');
      print('Digit 4: $digit4');
      print('Digit 5: $digit5');
      print('Digit 6: $digit6');
      print('Digit 7: $digit7');
      print('Digit 8: $digit8');
      print('Digit 9: $digit9');
      print('Digit 10: $digit10');
    } else {
      // Show an error or handle invalid input
      print('Invalid input. Please enter a 10-digit number.');
    }
  } catch (e) {
    print('Invalid input. Please enter a valid number.');
  }
}
