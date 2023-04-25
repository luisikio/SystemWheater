import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/screens/responsive/mobile_screen.dart';
import 'package:sistem_weatherv2/screens/responsive/responsive.dart';
import 'package:sistem_weatherv2/screens/responsive/web_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveScreen(
        mobileScreen: MobileScreen(),
        webScreen: WebScreen(),
      ),
    );
  }
}
