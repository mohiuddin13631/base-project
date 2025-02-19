import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:base_project/core/helper/shared_preference_helper.dart';
import 'package:base_project/data/services/api_service.dart';

import '../../../../core/route/route.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../data/controller/onboard/onboard_controller.dart';

class BottomSection extends StatelessWidget {
  final int index;
  const BottomSection({
    super.key,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardController>(
      builder: (controller) => controller.onboardImageList.length -1 == index ? GestureDetector(
        onTap: () {
          Get.find<ApiClient>().sharedPreferences.setBool(SharedPreferenceHelper.firstTimeAppOpeningStatus, false);
          Get.toNamed(RouteHelper.loginScreen);
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 150,
          decoration: BoxDecoration(
            color: MyColor.colorAmber,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Text(MyStrings.getStarted,style: boldLarge.copyWith(color: MyColor.colorBlack,fontWeight: FontWeight.w600),),
        ),
      ) :  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              controller.pageController.jumpToPage(controller.onboardImageList.length - 1);
            },
            child: Text(MyStrings.skip.tr,style: mediumLarge.copyWith(color: MyColor.onboardContentColor)),
          ),

          Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(controller.onboardImageList.length, (index) => Container(
                margin: const EdgeInsetsDirectional.only(end: 8),
                width: controller.currentIndex == index ? 24 : 14,
                height: 8,
                decoration: BoxDecoration(
                    color: controller.currentIndex == index ? MyColor.colorAmber : MyColor.onboardContentColor,
                    borderRadius: BorderRadius.circular(100)
                ),
              ))
          ),

          TextButton(
            onPressed: () {
              if(controller.onboardImageList.length - 1 == index){
                Get.find<ApiClient>().sharedPreferences.setBool(SharedPreferenceHelper.firstTimeAppOpeningStatus, false);
                Get.toNamed(RouteHelper.loginScreen);
              }else{
                controller.pageController.nextPage(duration: const Duration(milliseconds: 1), curve: Curves.easeInSine);
              }
            },
            child: Text(controller.onboardImageList.length - 1 == index ? MyStrings.finish.tr : MyStrings.next.tr,style: mediumLarge.copyWith(color: MyColor.onboardContentColor),),
          ),

        ],
      ),
    );
  }
}
