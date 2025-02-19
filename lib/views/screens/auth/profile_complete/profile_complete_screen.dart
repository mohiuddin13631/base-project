import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/dimensions.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/core/utils/style.dart';
import 'package:base_project/data/controller/account/profile_complete_controller.dart';
import 'package:base_project/data/repo/account/profile_repo.dart';
import 'package:base_project/data/services/api_service.dart';
import 'package:base_project/views/components/appbar/custom_appbar.dart';
import 'package:base_project/views/components/buttons/rounded_button.dart';
import 'package:base_project/views/components/buttons/rounded_loading_button.dart';
import 'package:base_project/views/components/text-field/custom_text_field.dart';
import 'package:base_project/views/components/will_pop_widget.dart';
import 'package:base_project/views/screens/auth/profile_complete/widget/country_bottom_sheet.dart';
import 'package:base_project/views/screens/auth/profile_complete/widget/image_widget.dart';

import '../../../../core/utils/url.dart';
import '../../../../data/services/push_notification_service.dart';
import '../../../components/image/my_image_widget.dart';
import '../../../components/text-field/label_text_field.dart';


class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find(), ));
    final controller = Get.put(ProfileCompleteController(profileRepo: Get.find()));
    Get.put(PushNotificationService(apiClient: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
    });

    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }
  
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return WillPopWidget(
      nextRoute: '',
      child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.getScreenBgColor(),
            appBar: CustomAppBar(
              title: MyStrings.profileComplete.tr,
              isShowBackBtn: true,
              fromAuth: false,
              isProfileCompleted: true,
            ),

            body: GetBuilder<ProfileCompleteController>(
              builder: (controller) => SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.space12,),
                      CustomImageWidget(imagePath: controller.imageFile?.path ?? '', onClicked: (){}),
                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                      CustomTextField(
                        labelText: "${MyStrings.username.tr}*",
                        hintText: MyStrings.enterUsername.tr,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.usernameFocusNode,
                        controller: controller.usernameController,
                        nextFocus: controller.mobileNoFocusNode,
                        onChanged: (value){
                          return;
                        },
                        validator: (value){
                          if(value!=null && value.toString().isEmpty){
                            return MyStrings.enterUsername.tr;
                          } else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

                      LabelTextField(
                        onChanged: (v) {},
                        hideLabel: true,
                        labelText: (MyStrings.phoneNo).replaceAll('.', '').tr,
                        hintText: MyStrings.enterYourPhoneNumber,
                        controller: controller.mobileNoController,
                        focusNode: controller.mobileNoFocusNode,
                        textInputType: TextInputType.phone,
                        inputAction: TextInputAction.next,
                        prefixIcon: SizedBox(
                          width: 100,
                          child: FittedBox(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    CountryBottomSheet.profileCompleteCountryBottomSheet(context, controller);
                                  },
                                  child: Container(
                                    padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space12),
                                    decoration: BoxDecoration(
                                      color: MyColor.transparentColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        MyImageWidget(
                                          imageUrl: UrlContainer.countryFlagImageLink.replaceAll('{countryCode}', controller.countryCode.toString().toLowerCase()),
                                          height: Dimensions.space25,
                                          width: Dimensions.space40 + 2,
                                        ),
                                        const SizedBox(width: Dimensions.space6),
                                        Text(controller.mobileCode ?? '',style: regularLarge,),
                                        const SizedBox(width: 3),
                                        const Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: MyColor.iconColor,
                                        ),
                                        Container(
                                          width: 2,
                                          height: Dimensions.space12,
                                          color: MyColor.borderColor,
                                        ),
                                        const SizedBox(width: Dimensions.space8)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                      CustomTextField(
                        
                        labelText: MyStrings.address,
                        hintText: MyStrings.enterYourAddress,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.addressFocusNode,
                        controller: controller.addressController,
                        nextFocus: controller.stateFocusNode,
                        onChanged: (value){
                          return;
                        },
                      ),
                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                      CustomTextField(
                        
                        labelText: MyStrings.state,
                        hintText: MyStrings.enterYourState,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.stateFocusNode,
                        controller: controller.stateController,
                        nextFocus: controller.cityFocusNode,
                        onChanged: (value){
                          return ;
                        },
                      ),
                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                      CustomTextField(
                        
                        labelText: MyStrings.city.tr,
                        hintText: MyStrings.enterYourCity,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        focusNode: controller.cityFocusNode,
                        controller: controller.cityController,
                        nextFocus: controller.zipCodeFocusNode,
                        onChanged: (value){
                          return ;
                        },
                      ),
                      const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
                      CustomTextField(
                        
                        labelText: MyStrings.zipCode.tr,
                        hintText: MyStrings.enterYourCountryZipCode,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        focusNode: controller.zipCodeFocusNode,
                        controller: controller.zipCodeController,
                        onChanged: (value){
                          return;
                        },
                      ),
                      const SizedBox(height: Dimensions.space35),
                      controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                        text: MyStrings.updateProfile.tr,
                        textColor: MyColor.colorWhite,
                        press: (){
                          if(formKey.currentState!.validate()){
                            controller.updateProfile();
                          }
                        },
                        color: MyColor.getPrimaryColor(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}
