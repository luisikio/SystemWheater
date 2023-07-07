import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sistem_weatherv2/screens/login/login_screen.dart';

void main() {
  testWidgets('iniciar sesion', (widgetTester) async {
    await Firebase.initializeApp();
    var widget = const LoginScreen();

    await widgetTester.pumpWidget(widget);

    expect(find.text('Login'), findsOneWidget);
  });
}
