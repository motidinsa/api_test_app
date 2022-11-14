import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/core/model/resource.dart';
import 'package:test_app/core/model/server_response.dart';
import 'package:test_app/core/model/user.dart';

class HomeController extends GetxController {
  RxList userList = [].obs;
  RxList resourceList = [].obs;
  RxBool isUserLoading = false.obs;
  RxBool isResourcesLoading = false.obs;
  RxBool isNextUserLoading = false.obs;
  RxBool isNextResourceLoading = false.obs;
  RxBool userLoading = false.obs;
  RxBool resourceLoading = false.obs;
  int pageNumber = 1;
  int resourcePageNumber = 1;
  RxBool hasNextPage = true.obs;
  RxBool resourceHasNextPage = true.obs;
  User? fetchedUser;
  Resource? fetchedResource;
  RxBool isCreating = false.obs;
  RxBool userCreated = false.obs;
  RxBool isUpdating = false.obs;
  RxBool userUpdated = false.obs;
  RxBool isDeleting = false.obs;
  RxBool isDeleted = false.obs;
  ServerResponse? serverResponse;

  Future<void> getUserList({bool? delay}) async {
    isUserLoading(true);
    userList([]);
    pageNumber = 1;
    hasNextPage(true);
    try {
      var url = Uri.parse(delay==true?'https://reqres.in/api/users?delay=3':'https://reqres.in/api/users');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        userList.addAll(jsonDecode(response.body)['data']
            .map((e) => User.fromJson(e))
            .toList());
        if (jsonDecode(response.body)['total_pages'] == pageNumber) {
          hasNextPage(false);
        }
      }
    }  finally {
      isUserLoading(false);
    }
  }

  Future<void> getNextUserList() async {
    isNextUserLoading(true);
    pageNumber++;
    try {
      var url = Uri.parse('https://reqres.in/api/users?page=$pageNumber');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        userList.addAll(jsonDecode(response.body)['data']
            .map((e) => User.fromJson(e))
            .toList());
        if (jsonDecode(response.body)['total_pages'] == pageNumber) {
          hasNextPage(false);
        }
      } else {
        // isSignUpSuccessful(false);
        // errorMessage(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      // errorMessage(e.toString());
      // isSignUpSuccessful(false);
    } finally {
      isNextUserLoading(false);
    }
  }

  Future<void> getUserDetail(String? id) async {
    userLoading(true);

    try {
      var url = Uri.parse('https://reqres.in/api/users/$id');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        fetchedUser = User.fromJson(jsonDecode(response.body)['data']);
      } else {}
    }  finally {
      userLoading(false);
    }
  }

  Future<void> getResourceDetail(String? id) async {
    resourceLoading(true);

    try {
      var url = Uri.parse('https://reqres.in/api/unknown/$id');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        fetchedResource = Resource.fromJson(jsonDecode(response.body)['data']);
      } else {}
    } finally {
      resourceLoading(false);
    }
  }

  Future<void> getResourceList() async {
    isResourcesLoading(true);
    resourceList([]);
    resourcePageNumber = 1;
    resourceHasNextPage(true);
    try {
      var url = Uri.parse('https://reqres.in/api/unknown');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        resourceList.addAll(jsonDecode(response.body)['data']
            .map((e) => Resource.fromJson(e))
            .toList());
        if (jsonDecode(response.body)['total_pages'] == resourcePageNumber) {
          resourceHasNextPage(false);
        }
      }
    } finally {
      isResourcesLoading(false);
    }
  }

  Future<void> getNextResourceList() async {
    isNextResourceLoading(true);
    resourcePageNumber++;
    try {
      var url =
          Uri.parse('https://reqres.in/api/unknown?page=$resourcePageNumber');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        resourceList.addAll(jsonDecode(response.body)['data']
            .map((e) => Resource.fromJson(e))
            .toList());
        if (jsonDecode(response.body)['total_pages'] == resourcePageNumber) {
          resourceHasNextPage(false);
        }
      }
    }finally {
      isNextResourceLoading(false);
    }
  }

  Future<void> create({String? name, String? job}) async {
    isCreating(true);
    userCreated(false);
    try {
      var url = Uri.parse('https://reqres.in/api/users');
      var response = await http.post(url,
          body: jsonEncode({
            "name": name,
            "job": job,
          }),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          });
      if (response.statusCode == 201) {
        userCreated(true);
        serverResponse =
            ServerResponse.fromJson(jsonDecode(response.body), false);
      }
    } catch (e) {
      userCreated(false);
    } finally {
      isCreating(false);
    }
  }

  Future<void> updateUser({String? name, String? job}) async {
    isUpdating(true);
    userUpdated(false);
    try {
      var url = Uri.parse('https://reqres.in/api/users/2');
      var response = await http.put(url,
          body: jsonEncode({
            "name": name,
            "job": job,
          }),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          });
      if (response.statusCode == 200) {
        userUpdated(true);
        serverResponse =
            ServerResponse.fromJson(jsonDecode(response.body), true);
      }
    } catch (e) {
      userUpdated(false);
    } finally {
      isUpdating(false);
    }
  }

  Future<void> deleteUser() async {
    isDeleting(true);
    isDeleted(false);
    try {
      var url = Uri.parse('https://reqres.in/api/users/2');
      var response = await http.delete(
        url,
      );
      if (response.statusCode == 204) {
        isDeleted(true);
      }
    } catch (e) {
      isDeleted(false);
    } finally {
      isDeleting(false);
    }
  }
}
