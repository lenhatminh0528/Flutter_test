import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:biocare_flutter/widgets/label/label_error.dart';

class OtpInput extends StatefulWidget {
  final String? error;
  final Function(String) onChanged;

  const OtpInput({Key? key, required this.error, required this.onChanged})
      : super(key: key);

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  String code = '------';
  String _error = "";
  int prevFocusIndex = 0;
  final List<TextEditingController>? listController =
      List<TextEditingController>.filled(6, TextEditingController());
  // TextEditingController controller = TextEditingController();

  final FocusNode _keyboardFocusNode = FocusNode();
  final List<FocusNode> listFoscus = List<FocusNode>.filled(6, FocusNode());

  @override
  void initState() {
    _assignController();
    super.initState();
  }

  void _handleFocusAtIndex(int index) {
    String text = listController![index].text;
    if (text.isEmpty) {
      listController![index].text = "_";
    }
  }

  void _assignController() {
    for (int i = 0; i < 6; i++) {
      listController?[i] = TextEditingController();
      listFoscus[i] = FocusNode();
      listFoscus[i].addListener(() {
        _handleFocusAtIndex(i);
      });
    }
  }

  Widget _ceilOtp(BuildContext context, autoFocus, index) {
    return SizedBox(
      height: 44,
      width: 48,
      child: TextFormField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        focusNode: listFoscus[index],
        controller: listController?[index],
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          hintText: "_",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        onTap: () {
          //CURSOR AUTO IN THE END OF TEXT.
          listController?[index].selection = TextSelection(
              baseOffset: listController?[index].text.length ?? 0,
              extentOffset: listController?[index].text.length ?? 0);
        },
        onChanged: (value) {
          //EDIT ONE FIELD WHICH ALREADY HAS VALUE
          if (value.length == 2) {
            listController?[index].text = listController![index].text[1];
          }

          if (listController![index].text.length == 1) {
            if (index == 5) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).nextFocus();
            }
          } else {
            if (index == 0) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).previousFocus();
            }
          }

          String text0 =
              listController![0].text.isEmpty ? '-' : listController![0].text;
          String text1 =
              listController![1].text.isEmpty ? '-' : listController![1].text;

          String text2 =
              listController![2].text.isEmpty ? '-' : listController![2].text;

          String text3 =
              listController![3].text.isEmpty ? '-' : listController![3].text;

          String text4 =
              listController![4].text.isEmpty ? '-' : listController![4].text;

          String text5 =
              listController![5].text.isEmpty ? '-' : listController![5].text;

          code = "$text0$text1$text2$text3$text4$text5";

          widget.onChanged(code);
        },
      ),
    );
  }

  Color _renderColorStatus() {
    if (_error.isEmpty == true) {
      return Colors.grey.shade300;
    } else {
      return Colors.red;
    }
  }

  Widget _renderOtpInputField(BuildContext context, autoFocus, index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(
          color: _renderColorStatus(),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: _ceilOtp(context, autoFocus, index),
    );
  }

  @override
  Widget build(BuildContext context) {
    _error = widget.error ?? "";
    return Column(
      children: [
        RawKeyboardListener(
          focusNode: _keyboardFocusNode,
          // onKey: _handleEventKeyboard,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _renderOtpInputField(context, false, 0),
              _renderOtpInputField(context, false, 1),
              _renderOtpInputField(context, false, 2),
              _renderOtpInputField(context, false, 3),
              _renderOtpInputField(context, false, 4),
              _renderOtpInputField(context, false, 5),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        widget.error?.isNotEmpty == true
            ? LblError(errText: _error)
            : Container(),
      ],
    );
  }
}
