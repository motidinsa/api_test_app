import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/homepage/controller/home_controller.dart';
import 'package:test_app/homepage/ui/list_resourses/resource_detail.dart';

class SingleResource extends StatelessWidget {
  SingleResource({Key? key}) : super(key: key);
  final HomeController homeController = Get.find();

  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    homeController.fetchedResource=null;
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
                        decoration: const InputDecoration(hintText: 'enter resource ID'),controller: textEditingController,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(onPressed: () {
                    homeController.getResourceDetail(textEditingController.value.text);
                  }, icon: const Icon(Icons.search))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => homeController.resourceLoading.isTrue
                  ? const CircularProgressIndicator()
                  : homeController.fetchedResource != null
                  ? ResourceDetail(
                resource: homeController.fetchedResource!,
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
