import 'package:audioplayers/audioplayers.dart';

 
Future<void> splitAndPlayAudio(String inputNumber) async {
    int number = int.parse(inputNumber);

    // Split the number into thousands, hundreds, tens, and ones
    int thousands = (number / 1000).truncate();
    int hundreds = ((number % 1000) / 100).truncate();
    int tens = ((number % 100) / 10).truncate();
    int ones = number % 10;
   String thousandsInWords = _convertToWords(thousands);
    String hundredsInWords = _convertToWords(hundreds);
    String tensInWords = _convertToWords(tens);
    String onesInWords = _convertToWords(ones);

    // Print the words
    print('Thousands: $thousandsInWords');
    print('Hundreds: $hundredsInWords');
    print('Tens: $tensInWords');
    print('Ones: $onesInWords');

    String hundredsRupee = '$hundredsInWords.wav';
    String tensRupee = '$tensInWords.wav';
    String onesRupee = '$onesInWords.wav';

    print("in hundred: $hundredsRupee");
    print("in tens: $tensRupee");
    print("in ones: $onesRupee");

    if (thousandsInWords != "Zero.wav") {
      String input = thousandsInWords;
  
  List<String> words = input.split(' ');

  if (words.length == 2) {
    String firstWord = words[0];
    String secondWord = words[1];

    print('First Word: $firstWord');
    print('Second Word: $secondWord');

   int firstNumber = convertWordToNumber(firstWord);
    int secondNumber = convertWordToNumber(secondWord);
       String firstNumberString = firstNumber.toString();
    String secondNumberString = secondNumber.toString();
  String result ="$firstNumberString$secondNumberString.wav";

    print("==========================================="+result);
    await playaudio(result, 1);    
     await playaudio("thousand.wav", 1);
     
  }
    
    if (words.length != 2) {
      String thousandsRupee = '$thousandsInWords.wav';
      if (thousandsRupee != "Zero.wav") {
        
     
      print("inside thousand"+thousandsRupee);
      await playaudio(thousandsRupee, 1);
      await playaudio("thousand.wav", 1);
      }
    } 
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


  late AudioPlayer _audioPlayer=AudioPlayer();
 Future<void> playaudio(String audio, int sec) async {
    print("Inside playaudio: $audio");
    return Future.delayed(Duration(seconds: sec), () {
      _audioPlayer.play(AssetSource(audio));
    });
  }

Future<void> splitMobileNumber(String inputNumber) async {
  try {
    print("inside splitMobileNumber $inputNumber");


    // Convert the input string to a list of digits
    List<int> digits = inputNumber.split('').map((e) => int.parse(e)).toList();

    for (int i = 0; i < digits.length; i++) {
      int digit = digits[i];

      // Convert each digit to words
      String digitInWords = _convertToWords(digit);

      // Print the words
      print('Digit ${i + 1}: $digitInWords');

      // Append ".wav" to the digit in words
      String digitAudio = '$digitInWords.wav';

      // You can call the playaudio function here if needed
      print("Playing audio for digit $digit");

      if (i == 0) {
        // If it's the first digit, pause for 3 seconds
        await Future.delayed(Duration(seconds: 2));
      } 

      await playaudio(digitAudio, 1);
        }
  } catch (e) {
    print('Invalid input. Please enter a valid number.');
  }
}


int convertWordToNumber(String word) {
  const Map<String, int> wordToNumber = {
    'Zero': 0,
    'One': 1,
    'Two': 2,
    'Three': 3,
    'Four': 4,
    'Five': 5,
    'Six': 6,
    'Seven': 7,
    'Eight': 8,
    'Nine': 9,
    'Ten': 10,
    'Twenty': 2,
    'Thirty': 3,
    'Forty': 4,
    'Fifty': 5,
    'Sixty': 6,
    'Seventy': 7,
    'Eighty': 8,
    'Ninety': 9,

  };

  return wordToNumber[word] ?? 0; // Default to 0 if the word is not in the mapping
}