import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SliberAppBarProducts extends StatelessWidget {
  const SliberAppBarProducts({
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
          'Productos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        background: LottieBuilder.asset(
          'assets/productos2.json',
          width: 220,
          height: 200,
          // fit: BoxFit.fill,
          alignment: Alignment.centerRight,
        ),
      ),
    );
  }
}
