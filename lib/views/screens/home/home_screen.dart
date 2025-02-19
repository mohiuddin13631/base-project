import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project/core/utils/my_color.dart';
import 'package:base_project/data/controller/home/home_controller.dart';
import 'package:base_project/data/repo/home/home_repo.dart';
import 'package:base_project/data/services/api_service.dart';
import 'package:base_project/views/components/custom_loader.dart';
import 'package:base_project/views/components/no_data/no_data_found_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    final controller = Get.put(HomeController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
            backgroundColor: MyColor.lScreenBgColor1,
            body: controller.isLoading ? const CustomLoader() : controller.noInternet?
            NoDataFoundScreen(
              isNoInternet: true,
              press:(value){
                if(value){
                  controller.changeNoInternetStatus(false);
                  controller.loadData();
                }
              },
            ) : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: RefreshIndicator(color: MyColor.primaryColor,
                backgroundColor: MyColor.colorWhite,
                onRefresh: () async {
                  await controller.loadData();
                },
                child: Container()
              ),
            ),
          // bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
        ),
      ),
    );
  }
}
