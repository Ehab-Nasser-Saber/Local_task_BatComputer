import 'package:flutter/material.dart';

import 'package:login_counter/core/extentions/validation.dart';
import 'package:login_counter/core/util/snackbar_message.dart';

import '../../core/color/colors.dart';
import '../../core/sqflite_database/sql_helper.dart';

import '../widgets/custom_text_field_for_auth.dart';
import '../widgets/login_button.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;
  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {});
    _passwordController.addListener(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: const Text(
          'The Bat Computer Counter App',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/download.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.2,
            ),
            CustomTextFieldForAuth(
              textEditingController: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: "Email",
              labelText: "Email",
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CustomTextFieldForAuth(
              textEditingController: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              hintText: "Password",
              labelText: "Password",
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            LoginButton(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                title: "Login",
                onPressed: _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty
                    ? () {
                        logIn();
                      }
                    : null),
          ],
        ),
      ),
    );
  }

  Future logIn() async {
    if (_emailController.text.isValidEmail &&
        _passwordController.text.isValidPassword) {
      try {
        SnackBarMessage().showSuccessSnackBar(
            message:
                "Success : ${await SQLHelper.doesUserExist(_emailController.text, _passwordController.text)}",
            context: context);
      } catch (error) {
        SnackBarMessage().showErrorSnackBar(
            message: "Something Went Wrong, try again later", context: context);
      }
    } else {
      if (!_emailController.text.isValidEmail) {
        SnackBarMessage().showErrorSnackBar(
            message: "Invalid email, Enter a valid Email", context: context);
      } else if (!_passwordController.text.isValidPassword) {
        SnackBarMessage().showErrorSnackBar(
            message: "Invalid Password, Enter a valid Password",
            context: context);
      }
    }
  }
}
