import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/style.dart';

class BottomSheetLabelText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  const BottomSheetLabelText({Key? key, required this.text, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      textAlign: textAlign,
      style:  regularLarge.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
