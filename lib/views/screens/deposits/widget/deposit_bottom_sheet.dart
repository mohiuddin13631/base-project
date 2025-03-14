import 'package:base_project/core/helper/string_format_helper.dart';
import 'package:base_project/core/utils/dimensions.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/core/utils/style.dart';
import 'package:base_project/data/controller/deposit/deposit_history_controller.dart';
import 'package:base_project/views/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:base_project/views/components/column/bottom_sheet_column.dart';
import 'package:base_project/views/components/column/label_column.dart';
import 'package:base_project/views/components/custom_container/bottom_sheet_container.dart';
import 'package:base_project/views/components/divider/custom_divider.dart';
import 'package:base_project/views/components/row_item/bottom_sheet_top_row.dart';
import 'package:base_project/views/components/text/bottom_sheet_label_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/deposit/deposit_history_response_model.dart';

class DepositBottomSheet{

  static void depositBottomSheet(BuildContext context,int index){
    CustomBottomSheet(child: GetBuilder<DepositController>(builder: (controller)=>Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     const BottomSheetTopRow(header:MyStrings.depositInfo),
     BottomSheetContainer(
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: BottomSheetColumn(header: MyStrings.paymentMethod, body:controller.depositList[index].gateway?.name??'')),
                Expanded(
                    child: BottomSheetColumn(
                        alignmentEnd:true,
                        header:MyStrings.amount, body: '${controller.curSymbol}${Converter.formatNumber(controller.depositList[index].amount??'')}')
                ),
              ],
            ),
            const SizedBox(height: Dimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: BottomSheetColumn(header: MyStrings.depositCharge, body:'${controller.curSymbol}${Converter.formatNumber(controller.depositList[index].charge??'0')}')
                ),
                Expanded(
                    child: BottomSheetColumn(alignmentEnd: true,header: MyStrings.payableAmount, body:'${controller.curSymbol}${Converter.sum(controller.depositList[index].amount??'0',controller.depositList[index].charge??'0')}')
                ),

               ],
            ),
            const SizedBox(height: Dimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: BottomSheetColumn(header:  MyStrings.conversionRate, body: "1 ${controller.currency} = ${Converter.formatNumber(controller.depositList[index].rate ?? "")} ${controller.depositList[index].methodCurrency}")
                ),
                Expanded(
                    child: BottomSheetColumn(alignmentEnd:true,header: MyStrings.finalAmount, body:'${controller.curSymbol}${Converter.formatNumber(controller.depositList[index].finalAmo??'')}')),

              ],
            ),
          ],
        )),
        Visibility(
          visible: controller.depositList[index].detail!=null && controller.depositList[index].detail!.isNotEmpty,
          child: BottomSheetContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomDivider(space: 18,borderColor: MyColor.borderColor,),
                BottomSheetLabelText(text: MyStrings.details.tr),
                const SizedBox(height: 12,),
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:controller.depositList[index].detail?.length??0,
                    itemBuilder: (BuildContext context, int detailsIndex) {
                      Details? details = controller.depositList[index].detail?[detailsIndex];
                      if(details?.value!=null && details!.value.toString().isNotEmpty && details.value.toString()!='null'){
                        return Container(
                          margin: const EdgeInsets.only(bottom: Dimensions.space10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: details?.type=='file'?InkWell(
                            onTap: (){
                              controller.downloadAttachment(details?.value??'',context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text((details?.name.toString().capitalizeFirst??'').tr,style: lightDefault.copyWith(color: MyColor.bodyTextColor),overflow: TextOverflow.ellipsis,),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.file_download,size: 17,color: MyColor.primaryColor,),
                                    const SizedBox(width: 12),
                                    Text(MyStrings.attachment.tr,style: regularDefault.copyWith(color: MyColor.primaryColor),)
                                  ],
                                ),
                              ],
                            ),
                          ): LabelColumn(header:(details?.name??'').tr, body: details?.value.toString()??''),
                        );
                      }
                      return const SizedBox.shrink();
                      },),
                )
              ],
            ),
          ),
        )
      ],
    )),).customBottomSheet(context);
  }
}