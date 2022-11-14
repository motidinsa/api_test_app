import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/core/model/user.dart';
import 'package:test_app/homepage/controller/home_controller.dart';
import 'package:test_app/homepage/ui/user_list/user_detail.dart';

class UserDetails extends StatelessWidget {
  final bool? delay;
  UserDetails({
    Key? key,this.delay
  }) : super(key: key);
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    homeController.getUserList(delay: delay);
    return Scaffold(
      body: Obx(() {
        return homeController.isUserLoading.isTrue
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => UserDetail(
                        user: homeController.userList[index] as User,
                        isLast: index == homeController.userList.length - 1 &&
                            homeController.hasNextPage.isTrue,
                      ),
                      itemCount: homeController.userList.length,
                    ),
                    if (homeController.isNextUserLoading.isTrue)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
            );
      }),
    );
  }
}
