import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../routes/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  singIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )
          .then(
        (_) {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.homeuserscreen,
              (route) => false,
            );
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No existe usuario con ese correo electrónico.'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contraseña incorrecta.'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (e.code == 'user-disabled') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El usuario está deshabilitado.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
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
    final wid = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: wid < 1000
          ? Column(
              children: [
                Flexible(
                  child: LottieBuilder.asset(
                    'assets/login.json',
                    width: 350,
                    height: 350,
                    fit: BoxFit.fill,
                  ),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //email
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
                      //password
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xffb4b4b4).withOpacity(0.4),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          obscureText: _obscureText,
                          focusNode: b,
                          controller: _passwordController,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(a);
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: '******',
                            labelText: 'Contraseña',
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            return (value != null && value.length >= 6)
                                ? null
                                : 'La contraseña debe de ser de 6 caracteres';
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.resetpasswordscreemd);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          width: double.infinity,
                          child: const Text(
                            'Olvidaste tu contraseña?',
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await singIn();
                          // ignore: use_build_context_synchronously
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color(0xff4861FF),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                            'Acceso unico para usuarios designados por la Jass'),
                      )
                    ],
                  ),
                ),
              ],
            )
          : Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 200),
                      child: LottieBuilder.asset(
                        'assets/login.json',
                        width: 300,
                        height: 520,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //email
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
                          //password
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffb4b4b4).withOpacity(0.4),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              autocorrect: false,
                              obscureText: _obscureText,
                              focusNode: b,
                              controller: _passwordController,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(a);
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    )),
                                border: InputBorder.none,
                                hintText: '******',
                                labelText: 'Contraseña',
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              validator: (value) {
                                return (value != null && value.length >= 6)
                                    ? null
                                    : 'La contraseña debe de ser de 6 caracteres';
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await singIn();
                              // ignore: use_build_context_synchronously
                              FocusScope.of(context).unfocus();
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xff4861FF),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                                'Acceso unico para usuarios designados por la Jass'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
