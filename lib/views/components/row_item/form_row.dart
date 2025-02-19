import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/style.dart';

class FormRow extends StatelessWidget {

  final String label;
  final bool isRequired;

  const FormRow({Key? key,
    required this.label,
    required this.isRequired
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label.tr,style: regularDefault.copyWith(color: MyColor.getLabelTextColor()),),
        Text(isRequired?' *':'',style: boldDefault.copyWith(color: MyColor.red),)
      ],
    );
  }
}
