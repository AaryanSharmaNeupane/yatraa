import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/login-screen";

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  var email = "";
  var password = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Screen")),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Email:',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15,
                    ),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter email';
                    } else if (!value.contains('@')) {
                      return 'please enter valid email';
                    }
                    return null;
                  }),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password:',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15,
                    ),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter password';
                    }
                    return null;
                  }),
            ),
            Container(
              margin: const EdgeInsets.only(left: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        setState(
                          () {
                            email = emailController.text;
                            password = passwordController.text;
                          },
                        );
                        Navigator.pushNamedAndRemoveUntil(
                            context, Home.routeName, (route) => false);
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(fontSize: 14),
                      ))
                ],
              ),
            ),
            Row(children: [
              const Text("Don't have an account?"),
              TextButton(
                  onPressed: () => {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const SignupScreen(),
                            transitionDuration: const Duration(seconds: 0),
                          ),
                        )
                      },
                  child: const Text('Signup')),
            ])
          ]),
        ),
      ),
    );
  }
}
