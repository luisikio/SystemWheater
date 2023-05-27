import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/widgets/body_responsive.dart';

import '../../widgets/drawer_list.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('WaterSystem'),
          backgroundColor: const Color(0xff4861FF),
          leading: Container(
            margin: const EdgeInsets.all(10),
            child: const Image(
              image: AssetImage('assets/logo.png'),
              color: Colors.white,
              width: 1,
              height: 1,
            ),
          )),
      endDrawer: const DrawerList(),
      body: const BodyResponsive(),
    );
  }
}
