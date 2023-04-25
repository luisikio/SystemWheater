import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/screens/homelogueado/home_logueado_mobile.dart';
import 'package:sistem_weatherv2/screens/homelogueado/home_logueado_web.dart';
import 'package:sistem_weatherv2/screens/homelogueado/responsive.dart';

class HomeLogueadoScreen extends StatefulWidget {
  const HomeLogueadoScreen({Key? key}) : super(key: key);

  @override
  State<HomeLogueadoScreen> createState() => _HomeLogueadoScreenState();
}

class _HomeLogueadoScreenState extends State<HomeLogueadoScreen> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLogueadoScreen(
      homeLogmobileScreen: HomeLogueadoMobileScreen(),
      homeLogwebScreen: HomeLogeuadoWebScreen(),
    );
  }
}
