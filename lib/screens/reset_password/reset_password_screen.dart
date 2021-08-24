import 'package:flutter/material.dart';

import 'package:alta_pos/utils/style.dart';


class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgotPasswordScreen> {

  final GlobalKey<FormState> _formKey = new GlobalKey();
  final TextEditingController _emailController = TextEditingController();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
  }

  Widget forgotPasswordBanner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/icon/logo.png", height: 35.0),
        Padding(
          padding: const EdgeInsets.only(left: 17.0, top: 7.0),
          child: Text(
            "Alta",
            style: TextStyle(
                fontFamily: "Sans",
                color: Colors.white,
                fontSize: 27.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 3.5),
          ),
        ),
      ],
    );
  }

  TextFormField emailFormField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please type in your email';
        }
        return null;
      },
      style: new TextStyle(color: Colors.white),
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      autofocus: false,
      decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.email,
              color: ColorStyle.primaryColor,
              size: 20,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 14.0),
          hintText: "Email",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: "Popins",
          ),
          labelStyle: TextStyle(color: Colors.white70,)
      ),
    );
  }

  Widget resetPasswordButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorStyle.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
      ),
      child: Text(
        "Reset Password",
        style: TextStyle(
          fontFamily: "Gotik",
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
          letterSpacing: 1.0),
      ),
      onPressed: () {
        print('email to reset');
      }
    );
  }

  Widget backToLoginButton() {
    return OutlinedButton(
      onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
      style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 94),
      ),
      child: Text(
        'Back to Login',
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Gotik'
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                forgotPasswordBanner(),
                SizedBox(height: 40),
                emailFormField(),
                SizedBox(height: 30),
                resetPasswordButton(),
                SizedBox(height: 20.0),
                backToLoginButton(),
              ],
            ),
          )
        ),
      ),
    );
  }
}
