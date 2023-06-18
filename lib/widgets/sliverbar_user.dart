import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SliverAppBarUser extends StatelessWidget {
  const SliverAppBarUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(right: 250),
        title: const Text(
          'Usuarios',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        background: LottieBuilder.asset(
          'assets/user2.json',
          width: 220,
          height: 200,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
