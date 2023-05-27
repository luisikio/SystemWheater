import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  FocusNode a = FocusNode();
  FocusNode b = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Ingrese correo electronico para restablecer contraseña'),
          const SizedBox(
            height: 20,
          ),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xffb4b4b4).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: a,
                    controller: _emailController,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(b);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'abc@gmail.com',
                      labelText: 'Correo electrónico',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = RegExp(pattern);

                      return regExp.hasMatch(value ?? '')
                          ? null
                          : 'Correo electronico invalido';
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4861FF),
                  ),
                  onPressed: () {
                    resetPass();
                  },
                  icon: const Icon(Icons.email_outlined),
                  label: const Text(
                    'Restablecer contraseña',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future resetPass() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'correo electrónico de restablecimiento de contraseña enviado'),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No existe usuario con ese correo electrónico.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'correo electrónico de restablecimiento de contraseña no enviado'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
