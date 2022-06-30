import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class PinCodeScreen extends StatefulWidget {
  static String routeName = "PinCodeScreen";
  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  void _connectGoogleFit() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Base Ruler")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(children: [
          const Text("Hello"),
          OtpTextField(
            numberOfFields: 6,
            fieldWidth: 44,
            borderColor: Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Verification Code"),
                      content: Text('Code entered is $verificationCode'),
                    );
                  });
            }, // end onSubmit
          ),
          ElevatedButton(
              onPressed: _connectGoogleFit,
              child: const Text("Connect google fit"))
        ]),
      ),
    );
  }
}
