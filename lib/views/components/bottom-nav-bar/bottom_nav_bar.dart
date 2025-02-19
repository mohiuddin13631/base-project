import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/views/components/will_pop_widget.dart';
import 'package:base_project/views/screens/home/home_screen.dart';
import 'package:base_project/views/screens/menu/menu_screen.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/my_strings.dart';
import 'widget/nav_bar_item_widget.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  List<Widget> screens = [
    const HomeScreen(),
    const HomeScreen(),
    const MenuScreen(),
    // PriceChangeAnimationDemo()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: "",
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          backgroundColor: MyColor.lScreenBgColor1,
          body: screens[currentIndex],
          bottomNavigationBar: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space10,horizontal: 3),
              margin: const EdgeInsets.only(bottom: 13,left: 5,right: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: MyColor.colorWhite,
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(color: Color.fromARGB(25, 0, 0, 0), offset: Offset(0, -3), blurRadius: 1),
                  BoxShadow(color: Color.fromARGB(25, 0, 0, 0), offset: Offset(0, 3), blurRadius: 1),
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavBarItem(
                    label:  MyStrings.home.tr,
                    imagePath: MyImages.homeIcon,
                    index:1,
                    isSelected: currentIndex == 0,
                    press: (){
                      setState(() {
                        currentIndex = 0;
                      });
                    }),

                  NavBarItem(
                    label: MyStrings.transfer.tr,
                    imagePath:MyImages.transferIcon2,
                    index:0,
                    isSelected: currentIndex == 1,
                    press: (){
                    setState(() {
                      currentIndex = 1;
                    });
                  }),

                  NavBarItem(
                    label: MyStrings.transaction.tr,
                    imagePath: MyImages.transactionIcon,
                    index:2,
                    isSelected: currentIndex == 2,
                    press: (){
                      setState(() {
                        currentIndex = 2;
                      });
                    }),

                   NavBarItem(
                    label: MyStrings.menu.tr,
                    // label: "MyStrings.menu.tr",
                    imagePath: MyImages.menuIcon,
                    index:2,
                    isSelected: currentIndex == 3,
                    press: (){
                      setState(() {
                        currentIndex = 3;
                      });
                    }),
                ],
              ),
            ),
          )),
      ),
    );
  }
}
