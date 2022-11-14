import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  RxBool isSignUpSuccessful = false.obs;
  RxString errorMessage = ''.obs;
  Future<void> signUp({
    String? email,
    String? password,
  }) async {
    errorMessage('');
    isSignUpSuccessful(false);
    try {
      var url = Uri.parse('https://reqres.in/api/register');
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
        isSignUpSuccessful(true);
      } else {
        isSignUpSuccessful(false);
        errorMessage(jsonDecode(response.body)['error']);
      }
    } catch (e) {
      errorMessage(e.toString());
      isSignUpSuccessful(false);
    }
  }
}
