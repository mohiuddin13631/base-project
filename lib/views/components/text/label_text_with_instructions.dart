import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/style.dart';
import 'package:base_project/core/utils/style.dart';
import 'package:base_project/core/utils/style.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';


class LabelTextInstruction extends StatelessWidget {
  final bool isRequired;
  final String text;
  final String? instructions;
  final TextAlign? textAlign;
  final TextStyle? textStyle;

  const LabelTextInstruction({
    super.key,
    required this.text,
    this.textAlign,
    this.textStyle,
    this.isRequired = false,
    this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> _tooltipKey = GlobalKey<TooltipState>();

    return isRequired
        ? Row(
            children: [
              Text(text.tr, textAlign: textAlign, style: textStyle ?? interSemiBoldDefault.copyWith(color: MyColor.labelTextColor)),
              const SizedBox(
                width: 2,
              ),
              if (instructions != null) ...[
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: Dimensions.space2, end: Dimensions.space10),
                  child: Tooltip(

                      key: _tooltipKey,
                      message: "$instructions",
                      child: GestureDetector(
                        onTap: () {
                          _tooltipKey.currentState?.ensureTooltipVisible();
                        },
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: Dimensions.space15,
                          color: MyColor.primaryColor.withOpacity(.5),
                        ),
                      )),
                ),
              ],
              Text(
                '*',
                style: interSemiBoldDefault.copyWith(color: MyColor.colorRed),
              ),
            ],
          )
        : Row(
            children: [
              Text(
                text.tr,
                textAlign: textAlign,
                style: textStyle ?? interSemiBoldDefault.copyWith(color: MyColor.labelTextColor),
              ),
              if (instructions != null) ...[
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: Dimensions.space2, end: Dimensions.space10),
                  child: Tooltip(
                      key: _tooltipKey,
                      message: "$instructions",
                      child: GestureDetector(
                        onTap: () {
                          _tooltipKey.currentState?.ensureTooltipVisible();
                        },
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: Dimensions.space15,
                          color: MyColor.getLabelTextColor().withOpacity(0.8),
                        ),
                      )),
                ),
              ],
            ],
          );
  }
}
