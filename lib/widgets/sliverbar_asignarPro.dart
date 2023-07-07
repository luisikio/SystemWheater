// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SliberAppBarAsigPro extends StatelessWidget {
  const SliberAppBarAsigPro({
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
          'Asignar productos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        background: LottieBuilder.asset(
          'assets/asignar.json',
          width: 220,
          height: 200,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
