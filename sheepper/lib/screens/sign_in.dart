import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sheepper/main.dart';
import 'package:sheepper/models/response/info_response.dart';

import 'package:sheepper/services/api/user.dart';
import 'package:sheepper/services/dio.dart';
import 'package:sheepper/services/share_preference.dart';
import 'package:sheepper/widgets/common/alert.dart';
import 'package:sheepper/widgets/common/button.dart';
import 'package:sheepper/widgets/common/custom_textfield.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const routeName = "/sign-in";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  void _loginHandler() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var result = await UserApi.login(
            _emailController.text, _passwordController.text);

        if (result is InfoResponse) {
          SharePreference.prefs.setString("token", result.data);
          DioInstance.dio.options.headers["Authorization"] =
              "Bearer ${result.data}";
          Future.delayed(const Duration(seconds: 1), (() {
            setState(() {
              isLoading = false;
            });
            Navigator.pushNamed(context, MyHomePage.routeName);
          }));
        }
      } on DioError catch (e) {
        setState(() {
          isLoading = false;
        });
        Alert.errorAlert(e, context);
      }
    }
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    } else if (value.length < 4) {
      return "Password must have at least 4 character";
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(right: 24, left: 24, top: 112),
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/sign_in_logo.png',
                    scale: 2,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'SHEEPPER',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 250,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'exam@mail.com',
                            labelText: 'Email',
                            border: UnderlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: 250,
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: '*********',
                            labelText: 'Password',
                            border: UnderlineInputBorder(),
                            prefixIcon: Icon(Icons.password),
                          ),
                          autofocus: true,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: passwordValidator,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: RichText(
                    text: TextSpan(
                      text: 'Forget password ?',
                      style: Theme.of(context).textTheme.caption,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, MyHomePage.routeName);
                        },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Column(children: [
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: Button(
                        text: "Login",
                        isLoading: isLoading,
                        clickHandler: _loginHandler),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: RichText(
                      text: TextSpan(
                        text: 'or Sign Up here',
                        style: const TextStyle(
                          color: Color(0xFF022B3A),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, MyHomePage.routeName);
                          },
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
