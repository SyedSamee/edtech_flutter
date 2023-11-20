import 'package:flutter/material.dart';

class Utils {
  Color primaryColor = Color(0xff77DEFF);
  ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor:
            MaterialStateColor.resolveWith((states) => Color(0xff77DEFF))),
    useMaterial3: true,
  );
  InputDecoration defualtInputDecoration(
    String? hintText,
  ) {
    return InputDecoration(
        border: InputBorder.none,
        hintText: hintText != null ? hintText : null,
        hintStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10));
  }

  CircularProgressIndicator defualtLoadingIndicator() {
    return CircularProgressIndicator();
  }

  defualtMessenger(BuildContext context, String msg, bool isError) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(msg),
          backgroundColor: isError ? Colors.redAccent : primaryColor),
    );
  }
}
