import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/dimensions.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/style.dart';

class PlanTabBar extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback press;

  const PlanTabBar(
      {Key? key,
      required this.text,
      required this.isActive,
      required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius:  BorderRadiusDirectional.circular(Dimensions.space30),
            color: isActive
                ? MyColor.primaryColor
                : MyColor.transparentColor,
          ),
          child: Text(
            text.tr,
            style: semiBoldDefault.copyWith(
                color: isActive
                    ? MyColor.colorWhite
                    : MyColor.colorBlack),
          ),
        ));
  }
}

