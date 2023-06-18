import 'package:flutter/material.dart';

import '../../routes/routes.dart';
import '../../widgets/body_responsive.dart';

class WebScreen extends StatelessWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('WaterSystem'),
        leading: wid < 1000
            ? Container(
                margin: const EdgeInsets.all(10),
                child: const Image(
                  image: AssetImage('assets/logo.png'),
                  color: Colors.white,
                  width: 1,
                  height: 1,
                ),
              )
            : null,
        actions: [
          if (wid > 1000)
            Expanded(
              child: Container(
                // margin: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),

                child: const Image(
                  image: AssetImage('assets/logo.png'),
                  color: Colors.white,
                  width: 1,
                  height: 1,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          if (wid > 1000)
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'WaterSystem',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (wid > 1000)
            Expanded(
                child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Blog',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ))
        ],
      ),
      endDrawer: wid < 1000 ? const Drawer() : null,
      body: const BodyResponsive(),
    );
  }
}
