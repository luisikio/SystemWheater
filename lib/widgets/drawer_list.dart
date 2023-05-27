import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../routes/routes.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 10.0),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xff4861FF),
              Colors.blue,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          BounceInRight(
                            child: Text(
                              item.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
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
          ],
        ),
      ),
    );
  }
}
