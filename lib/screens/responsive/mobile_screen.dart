import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../routes/routes.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SystemWheater'),
        ),
        drawer: const DrawerList(),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: const Color(0xffCEEBF3),
                child: const Center(
                  child: Text(
                    'SystemWheater',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.deepPurple,
              ),
            ),
          ],
        ));
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color(0xffCEEBF3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    'SW',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Expanded(
                flex: 3,
                child: ListView.builder(
                  itemCount: draweList.length,
                  itemExtent: 100,
                  itemBuilder: ((context, index) {
                    final item = draweList[index];
                    return GestureDetector(
                      onTap: () {
                        if (item.title == 'Login') {
                          Navigator.pushNamed(context, Routes.login);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 20,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(item.icon),
                            Text(item.title),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
