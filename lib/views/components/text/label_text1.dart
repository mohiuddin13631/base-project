import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/dimensions.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/style.dart';
import 'package:base_project/views/components/row_item/form_row.dart';

class LabelText1 extends StatelessWidget {

  final String text;
  final TextAlign? textAlign;
  final bool required;

  const LabelText1({
    Key? key,
    required this.text,
    this.textAlign,
    this.required = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return required?FormRow(label: text.tr, isRequired: true):Text(
      text.tr,
      textAlign: textAlign,
      style: regularDefault.copyWith(color: MyColor.getLabelTextColor(),fontWeight: FontWeight.w500,fontSize: Dimensions.fontLarge),
    );
  }
}
