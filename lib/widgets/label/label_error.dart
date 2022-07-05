import 'package:flutter/material.dart';

class LblError extends StatelessWidget {
  final String errText;
  const LblError({
    Key? key,
    required this.errText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        width: 4,
      ),
      Flexible(
        child: Text(
          errText,
        ),
      ),
    ]);
  }
}
