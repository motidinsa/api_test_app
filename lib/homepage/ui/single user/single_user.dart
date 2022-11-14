import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/homepage/controller/home_controller.dart';
import 'package:test_app/homepage/ui/user_list/user_detail.dart';

class SingleUser extends StatelessWidget {
  SingleUser({Key? key}) : super(key: key);
  final HomeController homeController = Get.find();

  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: const InputDecoration(hintText: 'enter user ID'),controller: textEditingController,
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(onPressed: () {
                    homeController.getUserDetail(textEditingController.value.text);
                  }, icon: const Icon(Icons.search))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => homeController.userLoading.isTrue
                  ? const CircularProgressIndicator()
                  : homeController.fetchedUser != null
                      ? UserDetail(
                          user: homeController.fetchedUser!,
                          isLast: false,
                        )
                      : Container())
            ],
          ),
        ),
      ),
    );
  }
}
