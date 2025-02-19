import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/dimensions.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/core/utils/style.dart';
import 'package:base_project/data/controller/auth/login_controller.dart';
import 'package:base_project/views/components/buttons/rounded_button.dart';
import 'package:base_project/views/components/buttons/rounded_loading_button.dart';
import 'package:base_project/views/components/text-field/custom_text_field.dart';
import 'package:base_project/views/screens/auth/login/widget/bottom_section.dart';
import 'package:base_project/views/screens/auth/login/widget/social_login_section.dart';

class LoginForm extends StatefulWidget {
  
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              labelText: MyStrings.usernameOrEmail,
              textInputType: TextInputType.name,
              hintText: MyStrings.enterUsernameOrEmail,
              controller: controller.emailController,
              focusNode: controller.emailFocusNode,
              nextFocus: controller.passwordFocusNode,
              inputAction: TextInputAction.next,
              onChanged: (value){},
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.fieldErrorMsg.tr;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height:Dimensions.space20),
            CustomTextField(
              labelText: MyStrings.password,
              isPassword: true,
              hintText: MyStrings.enterYourPassword,
              onChanged: (value){},
              isShowSuffixIcon: true,
              controller: controller.passwordController,
              focusNode: controller.passwordFocusNode,
              inputAction: TextInputAction.go,
              onSubmitted:(value){
                if(formKey.currentState!.validate()){
                  controller.loginUser();
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.fieldErrorMsg.tr;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height:Dimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.changeRememberMe();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                            fillColor: MaterialStatePropertyAll<Color>(controller.remember ?MyColor.primaryColor:Colors.transparent,),
                            activeColor:  controller.remember ?MyColor.primaryColor:Colors.transparent,
                            value: controller.remember,
                            side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                                width: 1.0,
                                color: controller.remember ? MyColor.transparentColor : MyColor.primaryColor),
                            ),
                            onChanged: (value) {
                              controller.changeRememberMe();
                            }
                        ),
                      ),
                      const SizedBox(width: Dimensions.space10),
                      Text(MyStrings.rememberMe.tr,
                        style: regularSmall.copyWith(color: MyColor.colorBlack),overflow: TextOverflow.ellipsis,)


                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    controller.clearData();
                    controller.forgetPassword();
                  },
                  child: Text(MyStrings.loginForgotPassword.tr, style: regularSmall.copyWith(color: MyColor.primaryColor,decorationColor:MyColor.primaryColor,decoration: TextDecoration.underline)),
                )
              ],
            ),
            const SizedBox(height: Dimensions.space35,),
            controller.isSubmitLoading ? const RoundedLoadingBtn() : RoundedButton(
              text: MyStrings.signIn,
              color: MyColor.primaryColor,
              textColor: MyColor.colorWhite,
              press: (){
                if(formKey.currentState!.validate()){
                  controller.loginUser();
                }
              }
            ),
            const SizedBox(height: Dimensions.space30),

            const SocialLoginSection(),
            const SizedBox(height: Dimensions.space30),
            const BottomSection()
          ],
        ),
      ),
    );
  }
}