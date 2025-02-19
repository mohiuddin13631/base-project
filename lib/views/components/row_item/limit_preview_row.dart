import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/dimensions.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/style.dart';

class LimitPreviewRow extends StatelessWidget {
  final String firstText, secondText;
  final bool showDivider;

  const LimitPreviewRow({
    Key? key,
    required this.firstText,
    required this.secondText,
    this.showDivider = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(firstText.tr,style: semiBold.copyWith(fontSize: Dimensions.fontSmall12,color: MyColor.getGreyText() )),
            Text(secondText.tr,style: semiBold.copyWith(fontSize: Dimensions.fontSmall,color: MyColor.getGreyText1() ))
          ],
        ),
        const SizedBox(height: 15),
        Visibility(
          visible: showDivider,
          child: Divider(height: .5, color: MyColor.getBorderColor(),),),
        Visibility(
          visible: showDivider,
          child: const SizedBox(height: 15),),
      ],
    );
  }
}
