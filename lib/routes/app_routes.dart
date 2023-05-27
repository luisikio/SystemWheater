import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/routes/routes.dart';
import 'package:sistem_weatherv2/screens/register/register_prodcutos.dart';

import 'package:sistem_weatherv2/screens/register/register_screen.dart';
import 'package:sistem_weatherv2/screens/users_screen/home_screen_user.dart';

import '../screens/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/users_screen/reset_password.dart/reset_password.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.login: (context) => const LoginScreen(),
    Routes.home: (context) => const HomeScreen(),
    Routes.registro: (context) => const RegisterScreen(),
    Routes.homeuserscreen: (context) => const HomeScreenUsers(),
    Routes.productosscreen: (context) => const ProductosScreeen(),
    Routes.resetpasswordscreemd: (context) => const ResetPasswordScreen(),
  };
}
