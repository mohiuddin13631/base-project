import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/route/route.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/my_images.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/data/controller/menu_/menu_controller.dart' as menu;
import 'package:base_project/data/repo/auth/general_setting_repo.dart';
import 'package:base_project/data/services/api_service.dart';
import 'package:base_project/views/components/appbar/custom_appbar.dart';
import 'package:base_project/views/components/divider/custom_divider.dart';
import 'package:base_project/views/components/will_pop_widget.dart';
import 'package:base_project/views/screens/menu/widget/delete_account_bottom_sheet_body.dart';

import '../../../../data/controller/localization/localization_controller.dart';
import '../../../core/utils/dimensions.dart';
import '../../components/bottom_sheet/custom_bottom_sheet.dart';
import 'widget/menu_card.dart';
import 'widget/menu_row_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    final controller = Get.put(menu.MyMenuController(repo: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizationController){
      return  GetBuilder<menu.MyMenuController>(builder: (menuController)=>WillPopWidget(
        nextRoute: RouteHelper.homeScreen,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.lScreenBgColor1,
            appBar: CustomAppBar(title: MyStrings.menu.tr, isShowBackBtn: false, isShowActionBtn: false, bgColor:  MyColor.getAppbarBgColor()),
            body: SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MenuCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        MenuRowWidget(
                          image: MyImages.profile,
                          label: MyStrings.profile,
                          onPressed: () => Get.toNamed(RouteHelper.profileScreen),
                        ),

                        const CustomDivider(space: Dimensions.space15),
                        MenuRowWidget(
                          image: MyImages.changePass,
                          label: MyStrings.changePassword.tr,
                          onPressed: () => Get.toNamed(RouteHelper.changePasswordScreen),
                        ),
                        const CustomDivider(space: Dimensions.space15),
                        MenuRowWidget(
                          image: MyImages.referral,
                          label: MyStrings.referral.tr,
                          onPressed: () => Get.toNamed(RouteHelper.referralScreen),
                        ),
                        const CustomDivider(space: Dimensions.space15),
                        MenuRowWidget(
                          image: MyImages.twoFactorAuth,
                          label: MyStrings.twoFactorAuth.tr,
                          onPressed: () => Get.toNamed(RouteHelper.twoFactorSetupScreen),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.space12),

                  MenuCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        MenuRowWidget(
                          image: MyImages.notificationIcon,
                          label: MyStrings.notification.tr,
                          onPressed: () => Get.toNamed(RouteHelper.notificationScreen),
                        ),

                        const CustomDivider(space: Dimensions.space15),

                        Visibility(
                          visible: menuController.isDepositEnable,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MenuRowWidget(
                              image: MyImages.deposit,
                              label: MyStrings.deposit.tr,
                              onPressed: () => Get.toNamed(RouteHelper.depositsScreen),
                            ),

                            const CustomDivider(space: Dimensions.space15),
                          ],
                        )),

                        Visibility(
                          visible: menuController.isWithdrawEnable,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MenuRowWidget(
                              image: MyImages.withdrawIcon,
                              label: MyStrings.withdraw.tr,
                              onPressed: () => Get.toNamed(RouteHelper.withdrawScreen),
                            ),
                            const CustomDivider(space: Dimensions.space15),
                          ],
                        )),

                        Visibility(
                            visible: menuController.langSwitchEnable,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MenuRowWidget(
                                  image: MyImages.language,
                                  label: MyStrings.language.tr,
                                  onPressed: (){
                                    Get.toNamed(RouteHelper.languageScreen);
                                  },
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.space12),
                  MenuCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        MenuRowWidget(
                          image: MyImages.supportTicket,
                          label: MyStrings.supportTicket.tr,
                          onPressed: () => Get.toNamed(RouteHelper.allTicketScreen)
                        ),

                        const CustomDivider(space: Dimensions.space15),
                        MenuRowWidget(
                          image: MyImages.termsAndCon,
                          label: MyStrings.terms.tr,
                          onPressed: (){
                            Get.toNamed(RouteHelper.privacyScreen);
                          },
                        ),
                        const CustomDivider(space: Dimensions.space15),
                        MenuRowWidget(
                          image: MyImages.faq,
                          label: MyStrings.faq.tr,
                          onPressed: (){
                            Get.toNamed(RouteHelper.faqScreen);
                          },
                        ),
                        const CustomDivider(space: Dimensions.space15),
                        MenuRowWidget(
                          image: MyImages.deleteAccount,
                          label: MyStrings.deleteAccount.tr,
                          onPressed: (){
                            const CustomBottomSheet(
                              isNeedMargin: true,
                              child: DeleteAccountBottomsheetBody(),
                            ).customBottomSheet(context);
                          },
                        ),
                        const CustomDivider(space: Dimensions.space15),
                        MenuRowWidget(
                          isLoading: menuController.logoutLoading,
                          image: MyImages.signOut,
                          label: MyStrings.signOut.tr,
                          onPressed: (){
                            menuController.logout();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
          ),
        ),
      ));
    });
  }
}
