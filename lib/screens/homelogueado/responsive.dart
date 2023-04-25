import 'package:flutter/material.dart';

class ResponsiveLogueadoScreen extends StatelessWidget {
  const ResponsiveLogueadoScreen(
      {Key? key,
      required this.homeLogmobileScreen,
      required this.homeLogwebScreen})
      : super(key: key);

  final Widget homeLogmobileScreen;
  final Widget homeLogwebScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return constrains.maxWidth < 600
            ? homeLogmobileScreen
            : homeLogwebScreen;
      },
    );
  }
}
