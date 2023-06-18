import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../routes/routes.dart';

class SliverListRegister extends StatelessWidget {
  const SliverListRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => SizedBox(
          height: 220,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            scrollDirection: Axis.vertical,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.registro);
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xff272D3D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Registrar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Flexible(
                        child: LottieBuilder.asset(
                          'assets/register.json',
                          width: 250,
                          height: 300,
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        childCount: 1,
      ),
    );
  }
}
