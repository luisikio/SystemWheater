import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/widgets/body_responsive.dart';

import '../../routes/routes.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WaterSystem'),
        leading: Container(
          margin: const EdgeInsets.all(10),
          child: const Image(
            image: AssetImage('assets/logo.png'),
            color: Colors.white,
            width: 1,
            height: 1,
          ),
        ),
      ),
      endDrawer: const Drawer(),
      body: const BodyResponsive(),
    );
  }
}

class Drawer extends StatelessWidget {
  const Drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xff1F2432),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, Routes.login);
      },
      child: const Icon(
        Icons.login_outlined,
        size: 50,
      ),
    );
  }
}
