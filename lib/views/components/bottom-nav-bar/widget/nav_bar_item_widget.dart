import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/style.dart';

import '../../../../core/utils/my_color.dart';

class NavBarItem extends StatelessWidget {

  final String imagePath;
  final int index;
  final String label;
  final VoidCallback press;
  final bool isSelected;

  const NavBarItem({Key? key,
    required this.imagePath,
    required this.index,
    required this.label,
    required this.isSelected,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child:  size.width < 385  ?
      Container(
        color: MyColor.colorWhite, padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
        child: Column(
          children: [
            imagePath.contains('svg') ? SvgPicture.asset(
              imagePath,
              colorFilter:ColorFilter.mode(
                isSelected ? MyColor.primaryColor : MyColor.iconColor,
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ) : Image.asset(
              imagePath,
              color: isSelected ? MyColor.primaryColor : MyColor.iconColor,
              width: 16, height: 16,
            ),
            const SizedBox(height: 4),
            Text(
              label.tr, textAlign: TextAlign.center,
              style: mediumDefault.copyWith(color: isSelected ? MyColor.primaryColor : MyColor.getPrimaryTextColor(),fontWeight: isSelected? FontWeight.w600 : FontWeight.w500,fontSize: 11)
            )
          ],
        )
      ): Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.025,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isSelected ? MyColor.primaryColor : MyColor.colorWhite,
        ),
        child: Row(
          mainAxisSize:MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            imagePath.contains('svg')?SvgPicture.asset(
              imagePath,
              colorFilter:ColorFilter.mode(
                isSelected ? MyColor.colorWhite : MyColor.iconColor,
                BlendMode.srcIn,
              ),
              width: 16,
              height: 16,
            ) : Image.asset(
              imagePath,
              color: isSelected ? MyColor.colorWhite : MyColor.iconColor,
              width: 16, height: 16,
            ),
            const SizedBox(width: 4),
            Text(
              label.tr, textAlign: TextAlign.center,
              style: mediumDefault.copyWith(color: isSelected ? MyColor.colorWhite : MyColor.getPrimaryTextColor(),fontWeight: isSelected? FontWeight.w600 : FontWeight.w500)
            )
          ],
        ),
      ),
    );
  }
}