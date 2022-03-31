import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Something Went Wrong")),
    );
  }
}

void showLoginFailed(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      content: Text("LogIn failed"),
      backgroundColor: Color(0xFFE8F1F8).withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 5,
    ),
  );
}

void showRequireLogin(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      content: Text(
        "You need to be signed in with your institute ID",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Color(0xFFE8F1F8).withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 5,
    ),
  );
}
