import 'package:flutter/material.dart';

class BaseMessageWidget extends StatelessWidget {
  const BaseMessageWidget({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return child ?? const SizedBox();
  }
}
