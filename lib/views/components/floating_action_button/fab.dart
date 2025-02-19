import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../core/utils/my_color.dart';

class FAB extends StatelessWidget {
  final Callback callback;
  final IconData icon;

  const FAB({Key? key, required this.callback, this.icon = Icons.add}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: FloatingActionButton(
        onPressed: callback,
        backgroundColor: MyColor.primaryColor,
        child: Icon(
          icon,
          color: MyColor.colorWhite,
        ),
      ),
    );
  }
}
