import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/core/model/resource.dart';
import 'package:test_app/homepage/controller/home_controller.dart';

class ResourceDetail extends StatelessWidget {
  final Resource resource;
  final bool isLast;
  final HomeController homeController = Get.find();

  ResourceDetail({Key? key, required this.resource, required this.isLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // homeController.fetchedUser=null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Card(
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('name:  ${resource.name}'),
                  Text('Last name:  ${resource.year}'),
                  Row(
                    children: [
                      const Text('color: '),
                      CircleAvatar(backgroundColor: Color(int.parse(resource.color.replaceAll("#", "0xff"))),radius: 15,)
                    ],
                  ),
                  Text('pantone value:  ${resource.pantoneValue}'),
                ],
              ),
            ),
          ),
          if (isLast && homeController.isNextResourceLoading.isFalse)
            TextButton(
                onPressed: () {
                  homeController.getNextResourceList();
                },
                child: const Text('Load more'))
        ],
      ),
    );
  }
}
