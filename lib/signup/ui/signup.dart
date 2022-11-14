import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_app/login/ui/login.dart';
import 'package:test_app/signup/controller/signup_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

TextEditingController emailTextEditingController = TextEditingController(text: "eve.holt@reqres.in");
TextEditingController passwordTextEditingController = TextEditingController(text: "pistol");
  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if(signUpController.errorMessage.isNotEmpty){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(signUpController.errorMessage.value),
                  ],
                ),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 10,
                    cornerSmoothing: 1,
                  ),
                ),
              ));
            });

          }
          else if(signUpController.isSignUpSuccessful.isTrue){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  const [
                    Text('Sign up successful. You can now log in'),
                  ],
                ),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 10,
                    cornerSmoothing: 1,
                  ),
                ),
              ));
              Get.off(const LogIn());
            });
          }
          return LoaderOverlay(
            child: ListView(
              shrinkWrap: true,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create account',
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: 35,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: ShapeDecoration(
                    // color: Colors.white,
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 15,
                        cornerSmoothing: 1,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  // margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailTextEditingController,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: UnderlineInputBorder(
                              borderRadius: SmoothBorderRadius(
                                cornerRadius: 10,
                                cornerSmoothing: 1,
                              ),
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(Icons.email_outlined),
                          labelText: 'email',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        obscureText: isPasswordVisible ? false : true,
                        controller: passwordTextEditingController,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: UnderlineInputBorder(
                              borderRadius: SmoothBorderRadius(
                                cornerRadius: 10,
                                cornerSmoothing: 1,
                              ),
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: isPasswordVisible
                                ? const Icon(Icons.visibility_off_rounded)
                                : const Icon(Icons.visibility),
                            onPressed: () {
                              setState(
                                    () {
                                  isPasswordVisible = !isPasswordVisible;
                                },
                              );
                            },
                          ),
                          labelText: 'password',
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(const LogIn());
                          }, child: const Text('Have an account? Log in')),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 15)),
                          onPressed: () async {
                            context.loaderOverlay.show();
                            await   signUpController.signUp(
                                email: emailTextEditingController.text, password: passwordTextEditingController.text);
                            context.loaderOverlay.hide();
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
