import 'package:alta_pos/utils/global.dart';
import 'package:flutter/material.dart';


PreferredSizeWidget generalAppBar(context, String title) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Theme.of(context).canvasColor,
    brightness: Brightness.dark,
    leading: Padding(
      padding: const EdgeInsets.all(10),
      child: BackButton(
        color: Colors.white,
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (title == 'Products') {
            currentOrder.clear();
            Navigator.pushReplacementNamed(context, '/dashboard');
          }
          else if (title == 'Search') {
            Navigator.pushNamed(context, '/cart');
          }
          else {
            Navigator.pop(context);
          }
        }
      )
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Sans",
        fontWeight: FontWeight.w600,
        fontSize: 18.5
      )
    ),
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Image.asset("assets/icon/logo.png"),
      ),
    ],
  );
}