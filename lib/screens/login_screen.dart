import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../widgets/login_buttons.dart';
import '../widgets/login_label.dart';
import '../main.dart';
import '../screens/home.dart';
import '../screens/sign_up_screen.dart';
import '../widgets/login_headers.dart';
import '../widgets/login_title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/login-screen";

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  String url = "$serverUrl/users/login/";
  final _formkey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        if (_formkey.currentState!.validate()) {
          setState(
            () {
              email = emailController.text;
              password = passwordController.text;
            },
          );
          final response = await Dio().post(url, data: {
            "email": email,
            "password": password,
          });
          sharedPreferences.setString("jwt-token", response.data['jwt']);

          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
              context, Home.routeName, (route) => false);
        }
      },
      child: button(context, "Login"),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text("or"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignupScreen()));
        },
        child: label(context, 'Don\'t have an account ?', 'Register'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 222, 222),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            title(context),
            header("Email:"),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    fillColor: Color.fromARGB(255, 201, 201, 201),
                    border: InputBorder.none,
                    filled: true,
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15,
                    ),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your email';
                    } else if (!value.contains('@')) {
                      return 'please enter valid email';
                    }
                    return null;
                  }),
            ),
            header("Password:"),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    fillColor: Color.fromARGB(255, 201, 201, 201),
                    border: InputBorder.none,
                    filled: true,
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15,
                    ),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your password';
                    }
                    return null;
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            _submitButton(),
            _divider(),
            _createAccountLabel(),
          ]),
        ),
      ),
    );
  }
}
