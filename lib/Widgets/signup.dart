import 'package:flutter/material.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quantam/auth_manager.dart';
import 'package:quantam/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController passwordController = TextEditingController();
String initialCountry = 'IN';
PhoneNumber number = PhoneNumber(
  isoCode: 'IN',
);

class _SignUpState extends State<SignUp> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      // physics: NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      children: [
        Expanded(
          flex: 22,
          child: Container(
              // height: MediaQuery.of(context).size.height * .62,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: backgroundColor,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 15,
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create an \nAccount", style: heading2),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    ' Name',
                    'John doe',
                    Icons.person,
                    false,
                    nameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    ' Email',
                    'johndoe@gmail.com',
                    Icons.email,
                    false,
                    emailController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Contact No', style: headingTextfield),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      print(number.phoneNumber);
                    },
                    onInputValidated: (bool value) {
                      print(value);
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DROPDOWN,
                    ),
                    textStyle: hintTextStyle,

                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: number,

                    inputDecoration: InputDecoration(
                        suffixIcon:
                            Icon(Icons.phone, color: primaryColor, size: 30),
                        hintText: '9876543210',
                        hintStyle: hintTextStyle),

                    textFieldController: phoneController,
                    formatInput: false,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    // inputBorder: OutlineInputBorder(),
                    onSaved: (PhoneNumber number) {
                      print('On Saved: $number');
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    ' Password',
                    '*********',
                    Icons.lock_outline,
                    true,
                    passwordController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                      SizedBox(width: 5),
                      RichText(
                          text: TextSpan(
                        text: "I agree with  ",
                        style: regular17pt.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                              text: "term & conditions",
                              style: regular17pt.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline))
                        ],
                      )),
                    ],
                  ),
                  Center(
                    child: RichText(
                        text: TextSpan(
                      text: "Already have an Account ? ",
                      style: regular15pt,
                      children: [
                        TextSpan(
                            text: "Sign In!",
                            style: regular17pt.copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    )),
                  ),
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
                    AuthManager().signUp(
                        emailController.text, passwordController.text, context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: primaryColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Text("REGISTER",
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
