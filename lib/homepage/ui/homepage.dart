import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_app/homepage/controller/home_controller.dart';
import 'package:test_app/homepage/ui/home_title.dart';

class Homepage extends StatelessWidget {
   Homepage({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
        child:
        Obx(() {
          homeController.isDeleting.isTrue
              ? context.loaderOverlay.show()
              : context.loaderOverlay.hide();
          if (homeController.isDeleted.isTrue) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Successfully deleted'),
                  ],
                ),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 10,
                    cornerSmoothing: 1,
                  ),
                ),
              ));
            });
          }
          return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ),
                    HomeTitle(
                      titleName: "List Users",
                      id: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    HomeTitle(
                      titleName: "Get single user",
                      id: 2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    HomeTitle(
                      titleName: "List Resources",
                      id: 3,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    HomeTitle(
                      titleName: "Get single resourse",
                      id: 4,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    HomeTitle(
                      titleName: "Create",
                      id: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    HomeTitle(
                      titleName: "Update",
                      id: 6,
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    HomeTitle(
                      titleName: "Delete",
                      id: 7,
                    ),
                    const SizedBox(
                      height: 5,
                    ),HomeTitle(
                      titleName: "Delayed response",
                      id: 8,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ));
        }),
      ),
    );
  }
}
