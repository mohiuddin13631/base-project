import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/dimensions.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/data/controller/withdraw/withdraw_confirm_controller.dart';
import 'package:base_project/data/model/withdraw/withdraw_preview_response_model.dart' as preview;
import 'package:base_project/data/repo/account/profile_repo.dart';
import 'package:base_project/data/services/api_service.dart';
import 'package:base_project/views/components/appbar/custom_appbar.dart';
import 'package:base_project/views/components/buttons/rounded_button.dart';
import 'package:base_project/views/components/buttons/rounded_loading_button.dart';
import 'package:base_project/views/components/checkbox/custom_check_box.dart';
import 'package:base_project/views/components/custom_loader.dart';
import 'package:base_project/views/components/custom_radio_button.dart';
import 'package:base_project/views/components/row_item/form_row.dart';
import 'package:base_project/views/components/text-field/custom_drop_down_button_with_text_field.dart';
import 'package:base_project/views/components/text-field/custom_text_field.dart';
import '../../../components/text/label_text_with_instructions.dart';
import 'widget/choose_file_list_item.dart';

class WithdrawConfirmScreen extends StatefulWidget {

  const WithdrawConfirmScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawConfirmScreen> createState() => _WithdrawConfirmScreenState();
}

class _WithdrawConfirmScreenState extends State<WithdrawConfirmScreen> {

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    String trxId = Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    final controller = Get.put(WithdrawConfirmController(repo: Get.find(), profileRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.trxId=trxId;
      controller.initData();
    });
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<WithdrawConfirmController>(builder: (controller)=>SafeArea(
      child: Scaffold(
          backgroundColor: MyColor.colorWhite,
          appBar: const CustomAppBar(title: MyStrings.withdrawConfirm),
          body: controller.isLoading?const CustomLoader():SingleChildScrollView(
            padding: Dimensions.previewPaddingHV,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 25),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: MyColor.colorWhite,
                  borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                  border: Border.all(color: MyColor.borderColor,width: 1)
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.formList.length,
                        itemBuilder: (ctx,index){
                          preview.FormModel? model=controller.formList[index];
                          return  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              model.type=='text' || model.type == 'number' || model.type == 'email' || model.type == 'url' ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    isShowInstructionWidget: true,
                                      instructions : model.instruction,
                                      hintText: '${((model.name??'').capitalizeFirst)?.tr}',
                                      needLabel: true,
                                      needOutlineBorder: true,
                                      labelText:( model.name??'').tr,
                                      isRequired: model.isRequired=='optional'?false:true,
                                      textInputType: model.type == 'number'
                                          ? TextInputType.number
                                          : model.type == 'email'
                                          ? TextInputType.emailAddress
                                          : model.type == 'url'
                                          ? TextInputType.url
                                          : TextInputType.text,
                                      validator: (value) {
                                        if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                          return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value){
                                        controller.changeSelectedValue(value, index);
                                      }),
                                  const SizedBox(height: 10,),
                                ],
                              ):model.type=='textarea'?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    isShowInstructionWidget: true,
                                      instructions: model.instruction,
                                      needLabel: true,
                                      maxLines: 5,
                                      textInputType: TextInputType.multiline,
                                      needOutlineBorder: true,
                                      labelText: (model.name??'').tr,
                                      isRequired: model.isRequired=='optional'?false:true,
                                      hintText: '${((model.name??'').capitalizeFirst)?.tr}',
                                      validator: (value) {
                                        if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                          return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value){
                                        controller.changeSelectedValue(value, index);
                                      }),
                                  const SizedBox(height: 10,),
                                ],
                              ):model.type=='select'?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LabelTextInstruction(
                                    text: model.name ?? '',
                                    isRequired: model.isRequired == 'optional' ? false : true,
                                    instructions: model.instruction,
                                  ),
                                  const SizedBox(
                                    height: Dimensions.textToTextSpace,
                                  ),
                                  CustomDropDownTextField(list: model.options??[],onChanged: (value){
                                    controller.changeSelectedValue(value,index);
                                  },selectedValue: model.selectedValue,),
                                ],
                              ):model.type=='radio'?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                  CustomRadioButton(title:model.name,selectedIndex:controller.formList[index].options?.indexOf(model.selectedValue??'')??0,list: model.options??[],onChanged: (selectedIndex){
                                    controller.changeSelectedRadioBtnValue(index,selectedIndex);
                                  },),
                                ],
                              ):model.type=='checkbox'?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LabelTextInstruction(
                                    text: model.name ?? '',
                                    isRequired: model.isRequired == 'optional' ? false : true,
                                    instructions: model.instruction,
                                  ),
                                  CustomCheckBox(selectedValue:controller.formList[index].cbSelected,list: model.options??[],onChanged: (value){
                                    controller.changeSelectedCheckBoxValue(index,value);
                                  },),
                                ],
                              ):model.type=='file'?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LabelTextInstruction(
                                    text: model.name ?? '',
                                    isRequired: model.isRequired == 'optional' ? false : true,
                                    instructions: model.instruction,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                      child: SizedBox(
                                        child:InkWell(
                                            onTap: (){
                                              controller.pickFile(index);
                                            }, child: ChooseFileItem(fileName: model.selectedValue??MyStrings.chooseFile.tr,)),
                                      )
                                  )
                                ],
                              ) :  model.type == 'datetime'
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                    child: CustomTextField(
                                        isShowInstructionWidget: true,
                                        instructions: model.instruction,
                                        isRequired: model.isRequired == 'optional' ? false : true,
                                        hintText: (model.name ?? '').toString().capitalizeFirst,
                                        needOutlineBorder: true,
                                        labelText: model.name ?? '',
                                        controller: controller.formList[index].textEditingController,
                                        // initialValue: controller.formList[index].selectedValue == "" ? (model.name ?? '').toString().capitalizeFirst : controller.formList[index].selectedValue,
                                        textInputType: TextInputType.datetime,
                                        readOnly: true,
                                        validator: (value) {
                                          print(model.isRequired);
                                          if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                            return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onTap: () {
                                          controller.changeSelectedDateTimeValue(index, context);
                                        },
                                        onChanged: (value) {
                                          print(value);
                                          controller.changeSelectedValue(value, index);
                                        }),
                                  ),
                                ],
                              ) : model.type == 'date'
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                    child: CustomTextField(
                                        isShowInstructionWidget: true,
                                        instructions: model.instruction,
                                        isRequired: model.isRequired == 'optional' ? false : true,
                                        hintText: (model.name ?? '').toString().capitalizeFirst,
                                        needOutlineBorder: true,
                                        labelText: model.name ?? '',
                                        controller: controller.formList[index].textEditingController,
                                        // initialValue: controller.formList[index].selectedValue == "" ? (model.name ?? '').toString().capitalizeFirst : controller.formList[index].selectedValue,
                                        textInputType: TextInputType.datetime,
                                        readOnly: true,
                                        validator: (value) {
                                          print(model.isRequired);
                                          if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                            return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onTap: () {
                                          controller.changeSelectedDateOnlyValue(index, context);
                                        },
                                        onChanged: (value) {
                                          print(value);
                                          controller.changeSelectedValue(value, index);
                                        }),
                                  ),
                                ],
                              )
                                  : model.type == 'time'
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.textToTextSpace),
                                    child: CustomTextField(
                                        isShowInstructionWidget: true,
                                        instructions: model.instruction,
                                        isRequired: model.isRequired == 'optional' ? false : true,
                                        hintText: (model.name ?? '').toString().capitalizeFirst,
                                        needOutlineBorder: true,
                                        labelText: model.name ?? '',
                                        controller: controller.formList[index].textEditingController,
                                        // initialValue: controller.formList[index].selectedValue == "" ? (model.name ?? '').toString().capitalizeFirst : controller.formList[index].selectedValue,
                                        textInputType: TextInputType.datetime,
                                        readOnly: true,
                                        validator: (value) {
                                          print(model.isRequired);
                                          if (model.isRequired != 'optional' && value.toString().isEmpty) {
                                            return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
                                          } else {
                                            return null;
                                          }
                                        },
                                        onTap: () {
                                          controller.changeSelectedTimeOnlyValue(index, context);
                                        },
                                        onChanged: (value) {
                                          print(value);
                                          controller.changeSelectedValue(value, index);
                                        }),
                                  ),
                                ],
                              ) : const SizedBox(),

                              const SizedBox(height: 5,),

                            ],
                          );
                        }
                    ),
                    const SizedBox(height: Dimensions.space25),
                    controller.submitLoading ?
                    const Center(child:RoundedLoadingBtn()) :
                    RoundedButton(
                      color: MyColor.getButtonColor(),
                      press: () {

                        if (formKey.currentState!.validate()) {
                          controller.submitConfirmWithdrawRequest();
                        }

                        // controller.submitConfirmWithdrawRequest();
                      },
                      text: MyStrings.submit.tr,
                      textColor: MyColor.getButtonTextColor(),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    ));
  }
}




