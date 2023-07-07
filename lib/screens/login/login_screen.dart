import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  late int valor;

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff1F2432),
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
                          await iniciarSesion(context);

                          //throw Exception();
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
          : wid < 1600
              ? formularioResponsive(context, wid)
              : formularioResponsive(context, wid),
    );
  }

  iniciarSesion(BuildContext context) {
    return () async {
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
            saveAdminData(_emailController.text, _passwordController.text);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // FirebaseCrashlytics.instance
          //     .setCustomKey('user', 'no registrado en la base de datos');
          // await Future.delayed(const Duration(seconds: 2));
          // FirebaseCrashlytics.instance.recordError(e, stackTrace);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No existe usuario con ese correo electrónico.'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (e.code == 'wrong-password') {
          // FirebaseCrashlytics.instance
          //     .setCustomKey('userPass', 'contraseña incorrecta');
          // await Future.delayed(const Duration(seconds: 2));
          // await FirebaseCrashlytics.instance.recordError(
          //   e,
          //   stackTrace,
          //   reason: 'a non-fatal error',
          //   information: [
          //     'further diagnostic information about the error',
          //     'version 2.0'
          //   ],
          // );
          // await FirebaseCrashlytics.instance
          //     .recordFlutterError(e as FlutterErrorDetails);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Contraseña incorrecta.'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (e.code == 'user-disabled') {
          // FirebaseCrashlytics.instance
          //     .setCustomKey('user', 'usuario deshabilitado');
          // await Future.delayed(const Duration(seconds: 2));
          // FirebaseCrashlytics.instance.recordError(e, stackTrace);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('El usuario está deshabilitado.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }();
  }

  Form formularioResponsive(BuildContext context, double pantalla) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Row(
        children: [
          Expanded(
            flex: pantalla > 1300 ? 2 : 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200),
              child: LottieBuilder.asset(
                'assets/login.json',
                width: 300,
                height: 520,
                fit: BoxFit.contain,
              ),
            ),
          ),
          pantalla > 1700
              ? const Expanded(
                  child: SizedBox(),
                )
              : const SizedBox(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  //email
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
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
                    onTap: () {
                      Navigator.pushNamed(context, Routes.resetpasswordscreemd);
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
                      await () async {
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
                              saveAdminData(_emailController.text,
                                  _passwordController.text);
                            },
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'No existe usuario con ese correo electrónico.'),
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
                      }();
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
          ),
        ],
      ),
    );
  }

  void saveAdminData(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('adminEmail', email);
    prefs.setString('adminPassword', password);
  }
}
