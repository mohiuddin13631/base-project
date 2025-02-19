import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/route/route.dart';
import 'package:base_project/core/utils/dimensions.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/core/utils/style.dart';
import 'package:base_project/data/controller/auth/auth/registration_controller.dart';
import 'package:base_project/views/components/buttons/rounded_button.dart';
import 'package:base_project/views/components/buttons/rounded_loading_button.dart';
import 'package:base_project/views/components/text-field/custom_text_field.dart';
import 'package:base_project/views/screens/auth/reset_password/widget/validation_widget.dart';

class RegistrationForm extends StatefulWidget {

  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              needLabel: true,
              labelText: MyStrings.firstName.tr,
              hintText: MyStrings.enterYourFirstName.tr,
              controller: controller.fNameController,
              focusNode: controller.firstNameFocusNode,
              textInputType: TextInputType.text,
              nextFocus: controller.lastNameFocusNode,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return MyStrings.enterYourFirstName.tr;
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                return;
              },
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

            CustomTextField(
              labelText: MyStrings.lastName.tr,
              hintText: MyStrings.enterYourLastName,
              controller: controller.lNameController,
              focusNode: controller.lastNameFocusNode,
              textInputType: TextInputType.text,
              inputAction: TextInputAction.next,
              nextFocus: controller.emailFocusNode,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return MyStrings.enterYourLastName.tr;
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                return;
              },
            ),

            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

            CustomTextField(
              needLabel: true,
              labelText: MyStrings.email.tr,
              hintText: MyStrings.enterYourEmail.tr,
              controller: controller.emailController,
              focusNode: controller.emailFocusNode,
              textInputType: TextInputType.emailAddress,
              inputAction: TextInputAction.next,
              validator: (value) {
                if (value!=null && value.isEmpty) {
                  return MyStrings.enterYourEmail.tr;
                } else if(!MyStrings.emailValidatorRegExp.hasMatch(value??'')) {
                  return MyStrings.invalidEmailMsg.tr;
                }else{
                  return null;
                }
              },
              onChanged: (value) {
                return;
              },
            ),


            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),

            Focus(
                onFocusChange: (hasFocus){
                  controller.changePasswordFocus(hasFocus);
                },
                child: CustomTextField(
                  isShowSuffixIcon: true,
                  isPassword: true,
                  labelText: MyStrings.password,
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocusNode,
                  nextFocus: controller.confirmPasswordFocusNode,
                  hintText: MyStrings.enterYourPassword.tr,
                  textInputType: TextInputType.text,
                  onChanged: (value) {
                    if (controller.checkPasswordStrength) {
                      controller.updateValidationList(value);
                    }
                  },
                  validator: (value) {
                    return controller.validatePassword(value ?? '');
                  },
                )),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            Visibility(
              visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
              child: ValidationWidget(
                list: controller.passwordValidationRules,
              ),
            ),
            // const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            CustomTextField(
              labelText: MyStrings.confirmPassword.tr,
              hintText: MyStrings.confirmYourPassword.tr,
              controller: controller.cPasswordController,
              focusNode: controller.confirmPasswordFocusNode,
              inputAction: TextInputAction.done,
              isShowSuffixIcon: true,
              isPassword: true,
              onChanged: (value) {},
              validator: (value) {
                if (controller.passwordController.text.toLowerCase() != controller.cPasswordController.text.toLowerCase()) {
                  return MyStrings.kMatchPassError.tr;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            CustomTextField(
              needLabel: true,
              labelText: "${MyStrings.referralCode.tr} (${MyStrings.optional.tr})",
              hintText: "${MyStrings.referralCode.tr} (${MyStrings.optional.tr})",
              controller: controller.referralCodeController,
              focusNode: controller.referralCodeFocusNode,
              textInputType: TextInputType.text,
              onChanged: (value) {
                return;
              },
            ),
            const SizedBox(height: Dimensions.textFieldToTextFieldSpace),
            Visibility(
                visible: controller.needAgree,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                          fillColor: MaterialStatePropertyAll<Color>(controller.agreeTC ?MyColor.primaryColor:Colors.transparent,),
                          activeColor:  controller.agreeTC ?MyColor.primaryColor:Colors.transparent,
                          value: controller.agreeTC,
                          side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                              width: 1.0,
                              color: controller.agreeTC ? MyColor.transparentColor : MyColor.primaryColor),
                          ),
                          onChanged: (value) {
                            controller.updateAgreeTC();
                          }
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Row(
                      children: [
                        Text(MyStrings.iAgreeWith.tr, style: interRegularDefault.copyWith(color: MyColor.colorBlack)),
                        const SizedBox(width: 3),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteHelper.privacyScreen);
                          },
                          child: Text(MyStrings.privacyPolicies.tr.toLowerCase(), style: interSemiBoldDefault.copyWith(
                              color: MyColor.primaryColor,
                              decoration: TextDecoration.underline,
                              fontSize: Dimensions.fontSmall,
                              decorationColor: MyColor.primaryColor
                          )),
                        ),
                        const SizedBox(width: 3),
                      ],
                    ),
                  ],
                )),
            const SizedBox(height: Dimensions.space30),
            controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                text: MyStrings.signUp,
                textColor: MyColor.colorWhite,
                color: MyColor.primaryColor,
                press: (){
                  if (formKey.currentState!.validate()) {
                    controller.signUpUser();
                  }
                }
            ),
            const SizedBox(height: Dimensions.space10),
          ],
        ),
      ),
    );
  }
}