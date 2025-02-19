import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/core/route/route.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/style.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(MyStrings.doNotHaveAccount.tr, style: regularDefault),
        TextButton(
          onPressed: () {
            Get.offAndToNamed(RouteHelper.registrationScreen);
          },
          child: Text(
            MyStrings.signUpNow.tr,
            style: regularDefault.copyWith(
                color: MyColor.primaryColor,
                decorationColor: MyColor.primaryColor,
                decoration: TextDecoration.underline
            ),
          ),
        )
      ],
    );
  }
}
