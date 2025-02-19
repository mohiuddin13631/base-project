import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/my_images.dart';

import '../../../core/utils/my_strings.dart';

class OnboardController extends GetxController {
  int currentIndex = 0;
  PageController? controller = PageController();

  void setCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  List<String> onboardTitleList = [
    MyStrings.onboardTitle_1,
    MyStrings.onboardTitle_2,
    MyStrings.onboardTitle_3,
  ];

  List<String> onboardSubTitleList = [
    MyStrings.onboardSubTitle_1,
    MyStrings.onboardSubTitle_2,
    MyStrings.onboardSubTitle_3,
  ];

  bool isLoading = true;

  List<String> onBoardImage = [];


  PageController pageController = PageController();

  List<String> onboardImageList = [
    MyImages.onboardImage1,
    MyImages.onboardImage2,
    MyImages.onboardImage3,
  ];

  void changeCurrentIndex(int index){
    currentIndex = index;
    update();
  }

  bool isShowBottomShape = false;
  bool isShowTopShape = false;

}
