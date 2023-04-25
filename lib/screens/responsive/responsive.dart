import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen(
      {super.key, required this.mobileScreen, required this.webScreen});

  final Widget mobileScreen;
  final Widget webScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return constrains.maxWidth < 600 ? mobileScreen : webScreen;
      },
    );
  }
}
