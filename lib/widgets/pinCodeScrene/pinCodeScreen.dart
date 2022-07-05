import 'dart:async';
import 'dart:developer';

import 'package:biocare_flutter/color_manager.dart';
import 'package:biocare_flutter/widgets/input/input_otp_view.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:health/health.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeScreen extends StatefulWidget {
  static String routeName = "PinCodeScreen";
  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  String errorText = "";
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  void _connectGoogleFit() {}

  void _activeError() {
    log("active error");
    // errorController?.add(ErrorAnimationType.shake);
    setState(() {
      errorText = "Show Text Error!!!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Base Ruler")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(children: [
          const Text("Hello"),
          OtpTextField(
            numberOfFields: 6,
            fieldWidth: 44,
            borderColor: const Color(0xFF512DA8),
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
                      title: const Text("Verification Code"),
                      content: Text('Code entered is $verificationCode'),
                    );
                  });
            }, // end onSubmit
          ),
          PinCodeTextField(
            appContext: context,
            pastedTextStyle: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
            ),
            length: 6,
            obscureText: true,
            obscuringCharacter: '*',
            obscuringWidget: const FlutterLogo(
              size: 24,
            ),
            blinkWhenObscuring: true,
            animationType: AnimationType.fade,
            validator: (v) {
              if (v!.length < 3) {
                return "I'm from validator";
              } else {
                return null;
              }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
            ),
            cursorColor: Colors.black,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            errorAnimationController: errorController,
            controller: textEditingController,
            keyboardType: TextInputType.number,
            boxShadows: const [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
            onCompleted: (v) {
              debugPrint("Completed");
            },
            // onTap: () {
            //   print("Pressed");
            // },
            onChanged: (value) {
              debugPrint(value);
              setState(() {
                currentText = value;
              });
            },
            beforeTextPaste: (text) {
              debugPrint("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          ),
          // PinCodeTextField(
          //   backgroundColor: Colors.red,
          //   appContext: context,
          //   pastedTextStyle: TextStyle(
          //     color: Colors.green.shade600,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   length: 6,
          //   // obscureText: true,
          //   // obscuringCharacter: '*',
          //   // obscuringWidget: const FlutterLogo(
          //   //   size: 24,
          //   // ),
          //   blinkWhenObscuring: true,
          //   animationType: AnimationType.fade,
          //   validator: (v) {
          //     if (v!.length < 3) {
          //       return "I'm from validator";
          //     } else {
          //       return null;
          //     }
          //   },
          //   pinTheme: PinTheme(
          //     shape: PinCodeFieldShape.box,
          //     borderRadius: BorderRadius.circular(10),
          //     fieldHeight: 44,
          //     fieldWidth: 44,
          //     activeFillColor: HexColor.fromHex("#F1F5F8"),
          //     activeColor: HexColor.fromHex("#F1F5F8"),
          //     inactiveColor: HexColor.fromHex("#F1F5F8"),
          //     inactiveFillColor: HexColor.fromHex("#F1F5F8"),
          //     selectedColor: Colors.blue,
          //     selectedFillColor: HexColor.fromHex("#F1F5F8"),
          //     errorBorderColor: Colors.red,
          //   ),
          //   hintCharacter: "-",
          //   hintStyle: const TextStyle(color: Colors.black),
          //   cursorColor: Colors.black,
          //   animationDuration: const Duration(milliseconds: 300),
          //   enableActiveFill: true,
          //   errorAnimationController: errorController,
          //   controller: textEditingController,
          //   keyboardType: TextInputType.number,
          //   boxShadows: const [
          //     BoxShadow(
          //       offset: Offset(0, 1),
          //       color: Colors.black12,
          //       blurRadius: 10,
          //     )
          //   ],
          //   onCompleted: (v) {
          //     log("Completed");
          //   },
          //   // onTap: () {
          //   //   print("Pressed");
          //   // },
          //   onChanged: (value) {
          //     // debugPrint(value);
          //     setState(() {
          //       currentText = value;
          //     });
          //   },
          //   beforeTextPaste: (text) {
          //     debugPrint("Allowing to paste $text");
          //     //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //     //but you can show anything you want here, like your pop up saying wrong paste format or etc
          //     return true;
          //   },
          // ),
          const SizedBox(
            height: 20,
          ),
          OtpInput(
              error: errorText,
              onChanged: (value) {
                setState(() {
                  currentText = value;
                });
              }),
          ElevatedButton(
              onPressed: _activeError, child: const Text("Active Error")),
          ElevatedButton(
              onPressed: _connectGoogleFit,
              child: const Text("Connect google fit"))
        ]),
      ),
    );
  }
}
