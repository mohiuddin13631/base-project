import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:base_project/core/utils/style.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../data/controller/menu_/menu_controller.dart';


class DeleteAccountBottomsheetBody extends StatefulWidget {
  const DeleteAccountBottomsheetBody({
    super.key,
  });

  @override
  State<DeleteAccountBottomsheetBody> createState() => _DeleteAccountBottomsheetBodyState();
}

class _DeleteAccountBottomsheetBodyState extends State<DeleteAccountBottomsheetBody> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyMenuController>(builder: (controller) {
      return SafeArea(
        child: LayoutBuilder(builder: (context, box) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: Dimensions.space25),
                Image.asset(
                  MyImages.userdeleteImage,
                  width: 120,
                  height: 120,
                  // fit: BoxFit.cover,
                ),
                const SizedBox(height: Dimensions.space25),
                Text(
                  MyStrings.deleteYourAccount.tr,
                  style: mediumDefault.copyWith(color: MyColor.colorBlack, fontSize: Dimensions.fontLarge),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.space25),
                Text(
                  MyStrings.deleteBottomSheetSubtitle.tr,
                  style: regularDefault.copyWith(color: MyColor.colorGrey.withOpacity(0.8), fontSize: Dimensions.fontLarge),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.space40),
                GestureDetector(
                  onTap: () {
                      controller.removeAccount();
                  },
                  child: Container(
                    width: context.width,
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: 17),
                    decoration: BoxDecoration(
                      color: MyColor.delteBtnColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: controller.removeLoading
                          ? const SizedBox(
                              width: Dimensions.fontExtraLarge + 3,
                              height: Dimensions.fontExtraLarge + 3,
                              child: CircularProgressIndicator(color: MyColor.delteBtnTextColor, strokeWidth: 2),
                            )
                          : Text(
                              MyStrings.deleteAccount.tr,
                              style: mediumDefault.copyWith(color: MyColor.delteBtnTextColor, fontSize: Dimensions.fontLarge),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.space10),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: context.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: MyColor.colorGrey2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        MyStrings.cancel.tr,
                        style: mediumDefault.copyWith(color: MyColor.colorBlack, fontSize: Dimensions.fontLarge),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}
