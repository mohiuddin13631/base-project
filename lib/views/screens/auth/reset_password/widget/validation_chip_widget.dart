import 'package:flutter/material.dart';
import 'package:base_project/core/utils/dimensions.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/core/utils/style.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
       Key? key,
       required this.name,
       required this.hasError
  }) : super(key: key);

  final String name;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          elevation: 0,
          shape: StadiumBorder(side: BorderSide(color: hasError?Colors.red:Colors.green,width: 1)),
          avatar: Icon(hasError?Icons.cancel:Icons.check_circle,color: hasError?Colors.red:Colors.green,size: 15,),
          label: Text(
            name,
            style: regularDefault.copyWith(
              fontSize: Dimensions.fontExtraSmall,
              color: hasError?Colors.red:Colors.green,
            ),
          ),
          backgroundColor: MyColor.getCardBg()
        ),
        const SizedBox(width: 5,),
      ],
    );
  }
}