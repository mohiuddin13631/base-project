import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:base_project/core/helper/string_format_helper.dart';
import 'package:base_project/core/utils/my_images.dart';
import 'package:base_project/core/utils/util.dart';
import 'package:base_project/views/screens/onboard/widget/bottom_section.dart';
import '../../../core/theme/theme_util.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/style.dart';
import '../../../data/controller/onboard/onboard_controller.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {

  @override
  void initState() {
    MyUtil.onboardScreen();
    Get.put(OnboardController());
    super.initState();
  }

  @override
  void dispose() {
    ThemeUtil.allScreenTheme();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.colorWhite,
        body: PageView.builder(
          controller: controller.pageController,
          itemCount: controller.onboardImageList.length,
          onPageChanged: (value) {
            controller.changeCurrentIndex(value);
          },
          itemBuilder: (context, index) {
            return Stack(
              children: [

                SizedBox(
                  height: context.height * .79,
                  child: Image.asset(
                    controller.onboardImageList[index],
                    height: double.maxFinite,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  bottom: 0,
                  child: Image.asset(
                    MyImages.bottomObject,
                    width: context.width,
                    height: context.height * .5,
                    fit: BoxFit.cover,
                    color: MyColor.primaryColor,
                  ),
                ),

                Positioned(
                    bottom: context.height * .14,
                    left: 5,
                    child: Image.asset(MyImages.creditCard,width: context.width * .1,height: context.width * .1,color: MyColor.colorWhite.withOpacity(.2),)
                ),
                Positioned(
                    bottom:  context.height * .3,
                    right: -3,
                    child: Image.asset(MyImages.hand,width: context.width * .12,height: context.width * .12,color: MyColor.colorWhite.withOpacity(.2),)
                ),

                Positioned(
                  bottom: 60,
                  child: Container(
                    width: context.width,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: context.width * .1),
                              child: Text(controller.onboardTitleList[index].toTitleCase().tr,style: boldLarge.copyWith(fontSize: 24,color: MyColor.onboardContentColor),),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: context.width * .08),
                              child: Text(controller.onboardSubTitleList[index].toTitleCase().tr,style: regularLarge.copyWith(color: MyColor.onboardContentColor,fontSize: 16),textAlign: TextAlign.center,),
                            )
                          ],
                        ),
                        SizedBox(height: context.height * .06,),
                        BottomSection(index: index)
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}




