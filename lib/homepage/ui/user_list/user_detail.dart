import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/core/model/user.dart';
import 'package:test_app/homepage/controller/home_controller.dart';

class UserDetail extends StatelessWidget {
  final User user;
  final bool isLast;
  final HomeController homeController = Get.find();

  UserDetail({Key? key, required this.user, required this.isLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    homeController.fetchedUser=null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Card(
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('First name:  ${user.firstname}'),
                      Text('Last name:  ${user.lastname}'),
                      Text('Email:  ${user.email}'),
                    ],
                  )
                ],
              ),
            ),
          ),
          if (isLast && homeController.isNextUserLoading.isFalse)
            TextButton(
                onPressed: () {
                  homeController.getNextUserList();
                },
                child: const Text('Load more'))
        ],
      ),
    );
  }
}
