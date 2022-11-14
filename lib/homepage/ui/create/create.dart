import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_app/homepage/controller/home_controller.dart';

class Create extends StatelessWidget {
  Create({Key? key}) : super(key: key);
  final TextEditingController nameTextEditingController =
      TextEditingController(text: "morpheus");
  final TextEditingController jobTextEditingController =
      TextEditingController(text: "leader");
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    homeController.userCreated(false);
    homeController.serverResponse = null;
    return Scaffold(
      body: SafeArea(
        child: LoaderOverlay(
          child: Obx(() {
            homeController.isCreating.isTrue
                ? context.loaderOverlay.show()
                : context.loaderOverlay.hide();
            if (homeController.userCreated.isTrue) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Successfully created'),
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
                        homeController.create(
                            name: nameTextEditingController.text,
                            job: jobTextEditingController.text);
                      },
                      child: const Text('Create')),
                  const SizedBox(
                    height: 20,
                  ),
                  if (homeController.serverResponse != null) ...[
                    Text('ID: ${homeController.serverResponse?.id}'),
                    const SizedBox(height: 5),
                    Text('name: ${homeController.serverResponse?.name}'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('job: ${homeController.serverResponse?.job}'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        'Created at: ${homeController.serverResponse?.createdAt}'),
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
