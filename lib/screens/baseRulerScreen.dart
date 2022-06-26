import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';

class BaseRulerScreen extends StatefulWidget {
  static const routeName = "/BaseRulerScreen";

  const BaseRulerScreen({Key? key}) : super(key: key);

  @override
  State<BaseRulerScreen> createState() => _BaseRulerScreenState();
}

class _BaseRulerScreenState extends State<BaseRulerScreen> {
  RulerPickerController? _rulerPickerController;
  int currentValue = 50;
  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: 0);
  }

  Widget _buildBtn(int value) {
    return InkWell(
      onTap: () {
        _rulerPickerController?.value = value;
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.blue,
          child: Text(
            value.toString(),
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Base Ruler")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(children: [
          const Text("Hello"),
          RulerPicker(
            controller: _rulerPickerController,
            beginValue: 30,
            endValue: 100,
            initValue: currentValue,
            scaleLineStyleList: const [
              ScaleLineStyle(
                  color: Colors.red, width: 1.5, height: 30, scale: 0),
              ScaleLineStyle(
                  color: Colors.blue, width: 1, height: 25, scale: 5),
              ScaleLineStyle(
                  color: Colors.yellow, width: 1, height: 15, scale: 1),
            ],
            // onBuildRulerScalueText: (index, scaleValue) {
            //   return ''.toString();
            // },
            onValueChange: (value) {
              setState(() {
                currentValue = value;
              });
            },
            width: MediaQuery.of(context).size.width,
            height: 80,
            rulerMarginTop: 8,
            // marker: Container(
            //     width: 8,
            //     height: 50,
            //     decoration: BoxDecoration(
            //         color: Colors.red.withAlpha(100),
            //         borderRadius: BorderRadius.circular(5))),
          ),
        ]),
      ),
    );
  }
}
