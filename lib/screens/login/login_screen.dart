import 'package:alta_pos/components/alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:alta_pos/utils/style.dart';
import 'package:alta_pos/utils/firebase_signin.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget loginBanner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/icon/logo.png", height: 35.0),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
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
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
        hintText: "Email",
        hintStyle: TextStyle(
          fontFamily: "Popins",
          color: Colors.grey
        ),
      ),
    );
  }

  TextFormField passwordFormField() {
    return TextFormField(
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please type in your password';
          }
          return null;
        },
        style: new TextStyle(color: Colors.white),
        textAlign: TextAlign.start,
        controller: _passwordController,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.vpn_key,
              size: 20,
              color: ColorStyle.primaryColor,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          filled: true,
          fillColor: Colors.transparent,
          hintText: "Password",
          hintStyle: TextStyle(
            fontFamily: "Popins",
            color: Colors.grey
          ),
        )
    );
  }

  Widget forgotPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/forgot');
          },
          child: Text(
            'Forgot password?',
            style: TextStyle(
              fontFamily: "Gotik",
              fontSize: 12.0,
              ),
            )
          )
      ],
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorStyle.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 110),
      ),
      child: Text(
        "Sign In",
        style: TextStyle(
          fontFamily: "Gotik",
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          letterSpacing: 1.0),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          String res = await signIn(_emailController.text, _passwordController.text);
          print(res);
          if (res == 'user-not-found') {
            showAlertDialog(context, 'Wrong email/password.');
          }
          else if (res == 'invalid-email') {
            showAlertDialog(context, 'Wrong email/password.');
          }
          else if (res == 'wrong-password') {
            showAlertDialog(context, 'Wrong email/password.');
          }
          else if (res == 'user-signed-in'){
            FocusScope.of(context).unfocus();
            Navigator.of(context).pushReplacementNamed('/dashboard');
          }
          else {
            showAlertDialog(context, 'Server is offline.');
          }
        }
        else {
          setState(() {
            _autoValidateMode = AutovalidateMode.onUserInteraction;
          });
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    loginBanner(),
                    SizedBox(height: 30),
                    emailFormField(),
                    SizedBox(height: 20),
                    passwordFormField(),
                    SizedBox(height: 10),
                    forgotPasswordButton(),
                    SizedBox(height: 20),
                    loginButton()
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async => false
    );
  }
}
