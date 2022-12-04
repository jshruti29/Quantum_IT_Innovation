import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quantam/Widgets/social_login_button.dart';
import 'package:quantam/auth_manager.dart';

import 'package:quantam/colors.dart';

import '../News/Presentation/Screens/SearchNews_Screen.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

//TextEditingController nameController = new TextEditingController();
TextEditingController emailController = new TextEditingController();
//TextEditingController phoneController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
String initialCountry = 'IN';
PhoneNumber number = PhoneNumber(
  isoCode: 'IN',
);

class _LogInState extends State<LogIn> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      // physics: NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      children: [
        Expanded(
          flex: 18,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: backgroundColor,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("SignIn into your\nAccount", style: heading2),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextfield(
                    ' Email',
                    'johndoe@gmail.com',
                    Icons.email,
                    false,
                    emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    ' Password',
                    '*********',
                    Icons.lock_outline,
                    true,
                    passwordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Forgot Password ?',
                      style: regular17pt.copyWith(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                      child: Text("Login with",
                          style: regular17pt.copyWith(
                              fontWeight: FontWeight.bold))),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AuthManager().continueWithGoogle(context);
                        },
                        child: SocialLoginButton(
                          image: 'assets/google.png',
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          AuthManager().continueWithFacebook(context);
                        },
                        child: SocialLoginButton(
                          image: 'assets/Facebook.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: GestureDetector(
                      child: RichText(
                          text: TextSpan(
                        text: "Don't have an Account ? ",
                        style: regular15pt,
                        children: [
                          TextSpan(
                              text: "Register Now",
                              style: regular17pt.copyWith(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              )),
        ),
        // Spacer(),
        Expanded(
          flex: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return const SearchNewsScreen();
                    // }));
                    AuthManager().signIn(
                        emailController.text, passwordController.text, context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: primaryColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text("LOGIN",
                            style: regular20pt.copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget CustomTextfield(String text, String hintText, IconData icon,
    bool ObscurseText, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(text, style: headingTextfield),
      TextFormField(
        obscureText: ObscurseText,
        obscuringCharacter: '*',
        controller: controller,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            isDense: true,
            suffixIcon: Icon(icon, color: primaryColor, size: 30),
            hintText: hintText,
            hintStyle: hintTextStyle),
        style: hintTextStyle,
      )
    ],
  );
}

Color getColor(Set<MaterialState> states) {
  return Colors.red;
}
