import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:base_project/core/helper/date_converter.dart';
import 'package:base_project/core/utils/dimensions.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/my_icons.dart';
import 'package:base_project/core/utils/my_images.dart';
import 'package:base_project/core/utils/my_strings.dart';
import 'package:base_project/core/utils/style.dart';
import 'package:base_project/core/utils/util.dart';
import 'package:base_project/data/controller/support/ticket_details_controller.dart';
import 'package:base_project/data/model/support/support_ticket_view_response_model.dart';
import 'package:base_project/data/repo/support/support_repo.dart';
import 'package:base_project/data/services/api_service.dart';

import '../../../../core/utils/url.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/buttons/rounded_loading_button.dart';
import '../../../components/circle_icon_button.dart';
import '../../../components/custom_loader.dart';
import '../../../components/image/custom_svg_picture.dart';
import '../../../components/image/my_image_widget.dart';
import '../../../components/text-field/label_text_field.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({super.key});

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  String title = "";
  @override
  void initState() {
    String ticketId = Get.arguments[0];
    title = Get.arguments[1];
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SupportRepo(apiClient: Get.find()));
    var controller = Get.put(TicketDetailsController(repo: Get.find(), ticketId: ticketId));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketDetailsController>(
      builder: (controller) => Scaffold(
        backgroundColor: MyColor.colorWhite,
          appBar: AppBar(
            title: Text(MyStrings.replyTicket,style: mediumMediumLarge.copyWith(color: MyColor.colorBlack),),
            backgroundColor: MyColor.colorWhite,
            actions: [
              if (controller.model.data?.myTickets?.status != '3')
                controller.isLoading ? const SizedBox.shrink() :
                GestureDetector(
                  onTap: () {
                    controller.closeTicket(controller.model.data?.myTickets?.id.toString() ?? '-1');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                        color: MyColor.colorRed.withOpacity(.2),
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: const Icon(Icons.close,color: MyColor.colorRed,size: 20,),
                  ),
                )
            ],
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back,color: MyColor.colorBlack)
            ),
          ),
          body: controller.isLoading
              ? const CustomLoader(
                  isFullScreen: true,
                )
              : SingleChildScrollView(
                  padding: Dimensions.defaultScreenPadding,
                  child: Container(
                    // padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyColor.colorWhite
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Container(
                          // color: MyColor.colorWhite,
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: MyColor.colorWhite,
                              border: Border.all(
                                color: MyColor.cardBorderColor,
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "[${MyStrings.ticket.tr}#${controller.model.data?.myTickets?.ticket ?? ''}] ${controller.model.data?.myTickets?.subject ?? ''}",
                                        style: semiBoldDefault.copyWith(
                                          color: MyColor.colorBlack,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: controller.getStatusColor(controller.model.data?.myTickets?.status ?? "0"), width: 1),
                                      ),
                                      child: Text(
                                        controller.getStatusText(controller.model.data?.myTickets?.status ?? '0'),
                                        style: regularDefault.copyWith(color: controller.getStatusColor(controller.model.data?.myTickets?.status ?? "0",isPriority: true),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.space15,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: MyColor.colorWhite,
                              border: Border.all(
                                color: MyColor.cardBorderColor.withOpacity(0.8),
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelTextField(
                                controller: controller.replyController,
                                maxLines: 5,
                                contentPadding: const EdgeInsets.all(Dimensions.space10),
                                isAttachment: true,
                                labelText: "",
                                hintText: MyStrings.yourReply.tr,
                                inputAction: TextInputAction.done,
                                onChanged: (value) {
                                  return;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(height: 20),
                              controller.attachmentList.isNotEmpty ? const SizedBox(height: 20) : const SizedBox.shrink(),
                              LabelTextField(
                                onTap: () {
                                  controller.pickFile();
                                },
                                readOnly: true,
                                contentPadding: const EdgeInsets.all(Dimensions.space10),
                                isAttachment: true,
                                labelText: MyStrings.attachment.tr,
                                hintText: MyStrings.enterFile.tr,
                                inputAction: TextInputAction.done,
                                onChanged: (value) {
                                  return;
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.pickFile();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
                                    margin: const EdgeInsets.all(Dimensions.space5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: MyColor.primaryColor,
                                    ),
                                    child: Text(
                                      MyStrings.upload,
                                      style: regularDefault.copyWith(color: MyColor.colorWhite),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(MyStrings.supportedFileHint, style: regularSmall.copyWith(color: MyColor.getGreyText())),
                              const SizedBox(height: Dimensions.space20),
                              controller.attachmentList.isNotEmpty
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Row(
                                            children: List.generate(
                                              controller.attachmentList.length,
                                              (index) => Row(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.all(Dimensions.space5),
                                                        decoration: const BoxDecoration(),
                                                        child: controller.isImage(controller.attachmentList[index].path)
                                                            ? ClipRRect(
                                                                borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                                                child: Image.file(
                                                                  controller.attachmentList[index],
                                                                  width: context.width / 5,
                                                                  height: context.width / 5,
                                                                  fit: BoxFit.cover,
                                                                ))
                                                            
                                                                : controller.isDoc(controller.attachmentList[index].path)
                                                                    ? 
                                                                    Container(
                                                                        width: context.width / 5,
                                                                        height: context.width / 5,
                                                                        decoration: BoxDecoration(
                                                                          color: MyColor.colorWhite,
                                                                          borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                                                          border: Border.all(color: MyColor.borderColor, width: 1),
                                                                        ),
                                                                        child:  const Center(
                                                                          child: CustomSvgPicture(
                                                                            image: MyIcons.doc,
                                                                            height: 45,
                                                                            width: 45,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        width: context.width / 5,
                                                                        height: context.width / 5,
                                                                        decoration: BoxDecoration(
                                                                          color: MyColor.colorWhite,
                                                                          borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                                                          border: Border.all(color: MyColor.borderColor, width: 1),
                                                                        ),
                                                                        child: const Center(
                                                                          child: CustomSvgPicture(
                                                                            image: MyIcons.pdfFile,
                                                                            height: 45,
                                                                            width: 45,
                                                                          ),
                                                                        ),
                                                                      ),
                                                      ),
                                                      CircleIconButton(
                                                        onTap: () {
                                                          controller.removeAttachmentFromList(index);
                                                        },
                                                        height: Dimensions.space20,
                                                        width: Dimensions.space20,
                                                        backgroundColor: MyColor.colorRed,
                                                        child: const Icon(
                                                          Icons.close,
                                                          color: MyColor.colorWhite,
                                                          size: Dimensions.space15,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          //
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: Dimensions.space30),
                              controller.submitLoading
                                  ? const RoundedLoadingBtn()
                                  : RoundedButton(
                                      isOutlined: true,
                                      verticalPadding: Dimensions.space15,
                                      color: MyColor.primaryColor,
                                      text: MyStrings.reply.tr,
                                      press: () {
                                        controller.uploadTicketViewReply();
                                      },
                                    ),
                              const SizedBox(height: Dimensions.space30),
                              controller.messageList.isEmpty
                            ? Container(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space20),
                                decoration: BoxDecoration(
                                  color: MyColor.bodyTextColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      MyStrings.noMSgFound.tr,
                                      style: regularDefault.copyWith(color: MyColor.colorGrey),
                                    ),
                                  ],
                                ))
                            : Container(
                                padding: const EdgeInsets.symmetric(vertical: 30),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.messageList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => TicketViewCommentReplyModel(
                                    index: index,
                                    messages: controller.messageList[index],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
    );
  }
}

class TicketViewCommentReplyModel extends StatelessWidget {
  const TicketViewCommentReplyModel({Key? key, required this.index, required this.messages}) : super(key: key);

  final SupportMessage messages;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketDetailsController>(
        builder: (controller) => Container(
              padding: const EdgeInsets.all(Dimensions.space10),
              margin: const EdgeInsets.only(bottom: Dimensions.space15),
              decoration: BoxDecoration(
                color: messages.adminId == "1" ? MyColor.pendingColor.withOpacity(0.1) : MyColor.cardColor,
                borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                border: Border.all(
                  color: messages.adminId == "1" ? MyColor.pendingColor : MyColor.borderColor,
                  strokeAlign: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: ClipOval(
                          child: Image.asset(
                            MyImages.user,
                            height: 30,
                            width: 30,
                            color: MyColor.naturalLight,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (messages.admin == null)
                                Text(
                                  '${messages.ticket?.name}',
                                  style: boldDefault.copyWith(color: MyColor.getTextColor()),
                                )
                              else
                                Text(
                                  '${messages.admin?.name}',
                                  style: boldDefault.copyWith(color: MyColor.getTextColor()),
                                ),
                              Text(
                                messages.adminId == "1" ? MyStrings.admin.tr : MyStrings.you.tr,
                                style: regularDefault.copyWith(color: MyColor.bodyTextColor),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateConverter.getFormatedSubtractTime(messages.createdAt ?? ''),
                            style: regularDefault.copyWith(color: MyColor.bodyTextColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                          ),
                          child: Text(
                            messages.message ?? "",
                            style: regularDefault.copyWith(
                              color: MyColor.bodyTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (messages.attachments?.isNotEmpty ?? false)
                    Container(
                      height: MediaQuery.of(context).size.width > 500 ? 100 : 100,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: messages.attachments != null
                              ? List.generate(
                            messages.attachments!.length,
                                (i) =>messages.attachments![i].isLoading ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30, vertical: Dimensions.space10),
                              decoration: BoxDecoration(
                                color: MyColor.getScreenBgColor(),
                                borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                              ),
                              child:  SpinKitThreeBounce(
                                size: 20.0,
                                color: MyColor.getPrimaryColor(),
                              ),
                            ) : GestureDetector(
                              onTap: () {
                                String url = '${UrlContainer.supportImagePath}${messages.attachments?[i].attachment}';
                                String ext = messages.attachments?[i].attachment!.split('.')[1] ?? 'pdf';
                                if (MyUtil.isImage(messages.attachments?[i].attachment.toString() ?? "")) {
                                  controller.downloadAttachment(url, messages.attachments?[i].id ?? -1, ext,messages.attachments![i]);
                                } else {
                                  controller.downloadAttachment(url, messages.attachments?[i].id ?? -1, ext,messages.attachments![i]);
                                }
                              },
                              child: Stack(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width > 500 ? 100 : 100,
                                      height: MediaQuery.of(context).size.width > 500 ? 100 : 100,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: MyColor.borderColor),
                                        borderRadius: BorderRadius.circular(Dimensions.mediumRadius),
                                      ),
                                      child: MyUtil.isImage(messages.attachments?[i].attachment.toString() ?? "")
                                          ? MyImageWidget(
                                        imageUrl: "${UrlContainer.supportImagePath}${messages.attachments?[i].attachment}",
                                        width: MediaQuery.of(context).size.width > 500 ? 100 : 100,
                                        height: MediaQuery.of(context).size.width > 500 ? 100 : 100,
                                      ) : MyUtil.isDoc(messages.attachments?[i].attachment.toString() ?? "")
                                          ? const Center(
                                        child: CustomSvgPicture(
                                          image: MyIcons.doc,
                                          height: 45,
                                          width: 45,
                                        ),
                                      ) : const Center(
                                        child: CustomSvgPicture(
                                          image: MyIcons.pdfFile,
                                          height: 45,
                                          width: 45,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ) : const [SizedBox.shrink()],
                        ),
                      ),
                    ),
                ],
              ),
            ));
  }
}
//