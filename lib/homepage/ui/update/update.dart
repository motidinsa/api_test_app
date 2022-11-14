import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_app/homepage/controller/home_controller.dart';

class Update extends StatelessWidget {
  Update({Key? key}) : super(key: key);
  final TextEditingController nameTextEditingController =
  TextEditingController(text: "morpheus");
  final TextEditingController jobTextEditingController =
  TextEditingController(text: "zion resident");
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    homeController.userUpdated(false);
    homeController.serverResponse = null;
    return Scaffold(
      body: SafeArea(
        child: LoaderOverlay(
          child: Obx(() {
            homeController.isUpdating.isTrue
                ? context.loaderOverlay.show()
                : context.loaderOverlay.hide();
            if (homeController.userUpdated.isTrue) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Successfully updated'),
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
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(hintText: 'enter name'),
                    controller: nameTextEditingController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: 'enter job'),
                    controller: jobTextEditingController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        homeController.updateUser(
                            name: nameTextEditingController.text,
                            job: jobTextEditingController.text);
                      },
                      child: const Text('update')),
                  const SizedBox(
                    height: 20,
                  ),
                  if (homeController.serverResponse != null) ...[

                    Text('name: ${homeController.serverResponse?.name}'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('job: ${homeController.serverResponse?.job}'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        'updated at: ${homeController.serverResponse?.createdAt}'),
                    const SizedBox(
                      height: 5,
                    ),
                  ]
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
