import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _smsCodeController = TextEditingController();

  String verificationId = '';

  Future<void> _verifyPhoneNumber() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+1${_phoneNumberController.text.trim()}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieve the code on Android devices
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Called when the auto-retrieval timer expires
          setState(() {
            this.verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithPhoneNumber() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: _smsCodeController.text.trim(),
      );
      await _auth.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: Text('Verify Phone Number'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _smsCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'SMS Code'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signInWithPhoneNumber,
              child: Text('Sign In with Phone Number'),
            ),
          ],
        ),
      ),
    );
  }
}
