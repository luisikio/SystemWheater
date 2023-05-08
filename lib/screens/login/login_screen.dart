import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../routes/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  singIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  FocusNode a = FocusNode();
  FocusNode b = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          height: 300,
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login'),
              //email
              TextFormField(
                focusNode: a,
                controller: _emailController,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(b);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              //password
              TextFormField(
                focusNode: b,
                controller: _passwordController,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(a);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  await singIn().then((_) => Navigator.pushNamedAndRemoveUntil(
                      context, Routes.homeuserscreen, (route) => false));
                },
                child: Container(
                  height: 30,
                  width: 60,
                  color: Colors.amberAccent,
                  child: const Text('ingresar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
