import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_app/homepage/ui/homepage.dart';
import 'package:test_app/login/controller/login_controller.dart';
import 'package:test_app/signup/ui/signup.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  TextEditingController emailTextEditingController =
      TextEditingController(text: "eve.holt@reqres.in");
  TextEditingController passwordTextEditingController =
      TextEditingController(text: "cityslicka");

  LogInController logInController = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (logInController.errorMessage.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(logInController.errorMessage.value),
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

          } else if (logInController.isLogInSuccessful.isTrue) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Log in successful.'),
                  ],
                ),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 10,
                    cornerSmoothing: 1,
                  ),
                ),
              ));
logInController.isLogInSuccessful(false);
              Get.to(()=>Homepage());
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
                      'Log in to account',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: ShapeDecoration(
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
                            Get.to(()=>const SignUp());
                          }, child: const Text('Create account')),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15)),
                          onPressed: () async {
                            context.loaderOverlay.show();
                            await logInController.signIn(
                                email: emailTextEditingController.text,
                                password: passwordTextEditingController.text);

                            context.loaderOverlay.hide();

                          },
                          child: const Text(
                            'Log in.',
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
