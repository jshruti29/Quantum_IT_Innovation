import 'package:flutter/material.dart';

class AppTextStyle {
  TextStyle headingStyle() {
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
  }

  TextStyle cardTitleStyle() {
    return TextStyle(
      color: Colors.grey[700],
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  TextStyle cardAuthorStyle() {
    return TextStyle(
      color: Colors.grey[500],
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
  }

  TextStyle cardOtherDetailsStyle() {
    return TextStyle(
      color: Colors.grey[300],
      fontWeight: FontWeight.w300,
      fontSize: 10,
    );
  }

  TextStyle cardDescriptionStyle() {
    return TextStyle(
      color: Colors.grey[700],
      fontSize: 13,
    );
  }
}
