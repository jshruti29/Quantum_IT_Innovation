import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quantam/Widgets/login.dart';
import 'package:quantam/Widgets/signup.dart';
import 'package:quantam/colors.dart';

class SignIN extends StatefulWidget {
  const SignIN({super.key});

  @override
  State<SignIN> createState() => _SignINState();
}

class _SignINState extends State<SignIN> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey.shade400,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            title: RichText(
                text: TextSpan(
              text: "   Social",
              style: heading1,
              children: [
                TextSpan(
                    text: " X",
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.w400))
              ],
            )),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(300, 100),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Colors.white
                    // Creates border
                    ),
                child: TabBar(
                  labelStyle: regular20pt,
                  unselectedLabelColor: regular20,
                  unselectedLabelStyle: regular20pt,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: primaryColor,
                    // Creates border
                  ), //Change background color from here
                  tabs: [
                    Tab(
                      text: "LOGIN",
                    ),
                    Tab(
                      text: "SIGN UP",
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              LogIn(),
              SignUp(),
            ],
          )),
    );
  }
}
