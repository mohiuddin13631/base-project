import 'package:flutter/material.dart';
import 'package:base_project/core/utils/dimensions.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/style.dart';

class TicketRow extends StatelessWidget {
  const TicketRow({
    Key? key,
    required this.header,
    required this.value,
    this.isStatus = false,
    this.isPriority = false,
    this.isAction = false,
    this.isSubject = false,
    this.color = MyColor.colorGrey,
    this.borderColor = MyColor.borderColor,
    this.textColor,
  }) : super(key: key);

  final String header;
  final String value;
  final bool isStatus;
  final bool isPriority;
  final bool isAction;
  final bool isSubject;
  final Color color;
  final Color borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                header,
                style: interRegularDefault.copyWith(color: textColor ?? MyColor.getPrimaryTextColor()),
              ),
            ),
            Flexible(
              child: isSubject
                  ? Text(
                      value,
                      style: interRegularDefault.copyWith(color: textColor ?? MyColor.getPrimaryTextColor()),
                      textAlign: TextAlign.end,
                      maxLines: 2,
                    )
                  : isPriority
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                              color: textColor ?? MyColor.getPrimaryTextColor().withOpacity(0.5),
                              border: Border.all(
                                color: textColor ?? MyColor.getBorderColor(),
                              ),
                              borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                          child: Text(
                            value,
                            style: interRegularDefault.copyWith(color: MyColor.colorWhite),
                          ),
                        )
                      : isStatus
                          ? Text(value, style: interBoldDefault.copyWith(color: textColor))
                          : Text(
                              value,
                              style: interRegularDefault.copyWith(color: MyColor.getTextColor()),
                            ),
            )
          ],
        ),
        isAction ? const SizedBox() : const SizedBox(height: 10),
        isAction ? const SizedBox() : const Divider(height: 2, color: MyColor.borderColor),
        isAction ? const SizedBox() : const SizedBox(height: 10)
      ],
    );
  }
}
