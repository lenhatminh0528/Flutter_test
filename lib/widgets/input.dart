import 'package:biocare_flutter/constant/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustom extends StatelessWidget {
  final String inputTitle;
  final String? note;
  final TextEditingController textEditingController;
  final bool isPassword;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String hintText;
  final IconButton? trailingIcon;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onchanged;
  final bool enabled;

  const InputCustom({
    Key? key,
    required this.inputTitle,
    this.note,
    required this.textEditingController,
    required this.isPassword,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.hintText,
    this.trailingIcon,
    this.onSubmitted,
    this.onchanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inputTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              // const Text.rich(
              //   TextSpan(
              //     text: 'Hello', // default text style
              //     children: <TextSpan>[
              //       TextSpan(
              //           text: ' beautiful ',
              //           style: TextStyle(fontStyle: FontStyle.italic)),
              //       TextSpan(
              //           text: 'world',
              //           style: TextStyle(fontWeight: FontWeight.bold)),
              //     ],
              //   ),
              // ),
              note != null
                  ? Text(
                      note!,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColor.attentionPrimary),
                    )
                  : Container(),
            ],
          ),
        ),
        SizedBox(
          child: TextField(
            controller: textEditingController,
            obscureText: isPassword,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: AppColor.greyTertiary,
                    fontWeight: FontWeight.normal,
                  ),
              suffixIcon: trailingIcon,
              enabledBorder: outlineInputBorder,
              disabledBorder: outlineInputBorder,
              border: outlineInputBorder,
              focusedBorder: outlineInputBorder.copyWith(
                borderSide: const BorderSide(color: AppColor.greyPrimary),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              fillColor: AppColor.bgLight,
              filled: true,
            ),
            onSubmitted: onSubmitted,
            onChanged: onchanged,
            textAlignVertical: TextAlignVertical.center,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            enabled: enabled,
          ),
        ),
      ],
    );
  }
}
