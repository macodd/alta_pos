import 'package:flutter/material.dart';

Future<void> showAlertDialog(context, content) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Error',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12,
              color: Colors.red,
              fontFamily: 'Sans'
          ),
        ),
        content: SingleChildScrollView(
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontFamily: 'Popins'
              ),
            )
        ),
        actionsPadding: EdgeInsets.zero,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text(
                  'Ok',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Gotik'
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      );
    },
  );
}