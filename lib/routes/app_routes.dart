import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/routes/routes.dart';
import 'package:sistem_weatherv2/screens/homelogueado/home_logueado.dart';
import 'package:sistem_weatherv2/screens/homelogueado/home_logueado_mobile.dart';
import 'package:sistem_weatherv2/screens/homelogueado/home_logueado_web.dart';
import 'package:sistem_weatherv2/screens/register/register_screen.dart';

import '../screens/home_screen.dart';
import '../screens/login/login_screen.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.login: (context) => const LoginScreen(),
    Routes.home: (context) => const HomeScreen(),
    Routes.homelogueado: (context) => const HomeLogueadoScreen(),
    Routes.homelogueadoWeb: (context) => const HomeLogeuadoWebScreen(),
    Routes.homelogueadoMobile: (context) => const HomeLogueadoMobileScreen(),
    Routes.registro: (context) => const RegisterScreen(),
  };
}
