import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LogInController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLogInSuccessful = false.obs;
  RxString errorMessage = ''.obs;
  Future<void> signIn({
    String? email,
    String? password,
  }) async {
    errorMessage('');
    isLogInSuccessful(false);
    try {
      var url = Uri.parse('https://reqres.in/api/login');
      var response = await http.post(url,
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          });
      if (response.statusCode == 200) {
        isLogInSuccessful(true);
      } else {
        isLogInSuccessful(false);
        errorMessage(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      errorMessage(e.toString());
      isLogInSuccessful(false);
    }
  }
}
