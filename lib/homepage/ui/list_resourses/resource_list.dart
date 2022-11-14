import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/core/model/resource.dart';
import 'package:test_app/homepage/controller/home_controller.dart';
import 'package:test_app/homepage/ui/list_resourses/resource_detail.dart';

class ResourceList extends StatelessWidget {
   ResourceList({Key? key}) : super(key: key);
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    homeController.getResourceList();
    return Scaffold(body: Obx(() {
      return homeController.isResourcesLoading.isTrue
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ResourceDetail(
                resource: homeController.resourceList[index] as Resource,
                isLast: index == homeController.resourceList.length - 1 &&
                    homeController.resourceHasNextPage.isTrue,
              ),
              itemCount: homeController.resourceList.length,
            ),
            if (homeController.isNextResourceLoading.isTrue)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      );
    }),);
  }
}
