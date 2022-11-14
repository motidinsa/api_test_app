import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/homepage/controller/home_controller.dart';
import 'package:test_app/homepage/ui/create/create.dart';
import 'package:test_app/homepage/ui/list_resourses/resource_list.dart';
import 'package:test_app/homepage/ui/list_resourses/single_resource.dart';
import 'package:test_app/homepage/ui/single%20user/single_user.dart';
import 'package:test_app/homepage/ui/update/update.dart';
import 'package:test_app/homepage/ui/user_list/user_list.dart';

class HomeTitle extends StatelessWidget {
  final String titleName;
  final int id;

  HomeTitle({Key? key, required this.titleName, required this.id})
      : super(key: key);
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      child: InkWell(
        onTap: () {
          switch (id) {
            case 1:
              Get.to(() => UserDetails());
              break;
            case 2:
              Get.to(() => SingleUser());
              break;
            case 3:
              Get.to(() => ResourceList());
              break;
            case 4:
              Get.to(() => SingleResource());
              break;
            case 5:
              Get.to(() => Create());
              break;
            case 6:
              Get.to(() => Update());
              break;
            case 7:
              homeController.deleteUser();
              break;
              case 8:
                Get.to(() => UserDetails(delay: true,));
              break;
            // default:
            //   print('yo');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            titleName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
