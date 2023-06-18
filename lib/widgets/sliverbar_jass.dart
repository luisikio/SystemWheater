import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SliberAppBarJass extends StatelessWidget {
  const SliberAppBarJass({
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
          'Jas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        background: LottieBuilder.asset(
          'assets/jass.json',
          width: 220,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
