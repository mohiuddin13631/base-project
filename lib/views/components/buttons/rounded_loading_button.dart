import 'package:flutter/material.dart';
import 'package:base_project/core/utils/my_color.dart';

class RoundedLoadingBtn extends StatelessWidget {
  final Color? textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  const RoundedLoadingBtn({
    Key? key,
    this.width=1,
    this.cornerRadius=50,
    this.horizontalPadding=35,
    this.verticalPadding=18,
    this.textColor = MyColor.colorWhite,
  }):super(key: key) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cornerRadius)),
            backgroundColor: MyColor.primaryColor,
            shadowColor: MyColor.transparentColor,
            padding:  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding-3),
            textStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
        child: const SizedBox(width:20, height:20, child: CircularProgressIndicator(color: MyColor.colorWhite, strokeWidth: 2)),
      ),
    );
  }

}
