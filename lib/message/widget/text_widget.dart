// ignore_for_file: overridden_fields

import 'package:bit_im/message/widget/widget.dart';
import 'package:flutter/material.dart';

class TextMessageWidget extends BaseMessageWidget {
  const TextMessageWidget({super.key, required this.message, this.textStyle});
  final TextStyle? textStyle;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Text(message, style: textStyle);
  }
}
