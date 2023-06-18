// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sistem_weatherv2/screens/login/login_screen.dart';





// void main() {
//   late MockFirebaseAuth mockFirebaseAuth;
//   late LoginScreen loginScreen;

//   setUp(() {
//     mockFirebaseAuth = MockFirebaseAuth();
//     loginScreen = LoginScreen();
//   });

//   testWidgets('El inicio de sesión exitoso debe navegar a la pantalla de inicio del usuario', (WidgetTester tester) async {
//     // Stub the signInWithEmailAndPassword method of FirebaseAuth
//     when(mockFirebaseAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
//         .thenAnswer((_) => Future<UserCredential>.value(MockUserCredential()));

//     await tester.pumpWidget(
//       MaterialApp(
//         home: loginScreen,
//       ),
//     );

//     // Simula la entrada de datos en los campos de correo electrónico y contraseña
//     await tester.enterText(find.byKey(Key('emailField')), 'example@gmail.com');
//     await tester.enterText(find.byKey(Key('passwordField')), 'password');

//     // Simula el toque en el botón de inicio de sesión
//     await tester.tap(find.byKey(Key('signInButton')));

//     // Espera a que se complete la acción de inicio de sesión
//     await tester.pumpAndSettle();

//     // Verifica si se ha llamado a la función de inicio de sesión de FirebaseAuth
//     verify(mockFirebaseAuth.signInWithEmailAndPassword(email: 'example@gmail.com', password: 'password')).called(1);

//     // Verifica si se ha guardado el correo electrónico y la contraseña en algún lugar (por ejemplo, en SharedPreferences)
//     // ...

//     // Verifica si se ha navegado a la pantalla de inicio de usuario
//     expect(find.text('Home User Screen'), findsOneWidget);
//   });

//   testWidgets('El inicio de sesión fallido debe mostrar un mensaje de error', (WidgetTester tester) async {
//     // Stub the signInWithEmailAndPassword method of FirebaseAuth to throw an error
//     when(mockFirebaseAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
//         .thenThrow(FirebaseAuthException(code: 'wrong-password'));

//     await tester.pumpWidget(
//       MaterialApp(
//         home: loginScreen,
//       ),
//     );

//     // Simula la entrada de datos en los campos de correo electrónico y contraseña
//     await tester.enterText(find.byKey(Key('emailField')), 'example@gmail.com');
//     await tester.enterText(find.byKey(Key('passwordField')), 'wrongpassword');

//     // Simula el toque en el botón de inicio de sesión
//     await tester.tap(find.byKey(Key('signInButton')));

//     // Espera a que se complete la acción de inicio de sesión
//     await tester.pumpAndSettle();

//     // Verifica si se ha llamado a la función de inicio de sesión de FirebaseAuth
//     verify(mockFirebaseAuth.signInWithEmailAndPassword(email: 'example@gmail.com', password: 'wrongpassword')).called(1);

//     // Verifica si se ha mostrado un SnackBar con el mensaje de error correcto
//     expect(find.text('Contraseña incorrecta.'), findsOneWidget);
//     expect(find.text('No existe usuario con ese correo electrónico.'), findsNothing);
//     expect(find.text('El usuario está deshabilitado.'), findsNothing);
//   });
// }

// // Mock class for UserCredential
// // Mock class for UserCredential
// class MockUserCredential extends Mock implements UserCredential {}

// testWidgets('El inicio de sesión con usuario no encontrado debe mostrar un mensaje de error', (WidgetTester tester) async {
//   // Stub the signInWithEmailAndPassword method of FirebaseAuth to throw an error
//   when(mockFirebaseAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
//       .thenThrow(FirebaseAuthException(code: 'user-not-found'));

//   await tester.pumpWidget(
//     MaterialApp(
//       home: loginScreen,
//     ),
//   );

//   // Simula la entrada de datos en los campos de correo electrónico y contraseña
//   await tester.enterText(find.byKey(Key('emailField')), 'nonexistent@gmail.com');
//   await tester.enterText(find.byKey(Key('passwordField')), 'password');

//   // Simula el toque en el botón de inicio de sesión
//   await tester.tap(find.byKey(Key('signInButton')));

//   // Espera a que se complete la acción de inicio de sesión
//   await tester.pumpAndSettle();

//   // Verifica si se ha llamado a la función de inicio de sesión de FirebaseAuth
//   verify(mockFirebaseAuth.signInWithEmailAndPassword(email: 'nonexistent@gmail.com', password: 'password')).called(1);

//   // Verifica si se ha mostrado un SnackBar con el mensaje de error correcto
//   expect(find.text('No existe usuario con ese correo electrónico.'), findsOneWidget);
//   expect(find.text('Contraseña incorrecta.'), findsNothing);
//   expect(find.text('El usuario está deshabilitado.'), findsNothing);
// });

// testWidgets('El inicio de sesión con usuario deshabilitado debe mostrar un mensaje de error', (WidgetTester tester) async {
//   // Stub the signInWithEmailAndPassword method of FirebaseAuth to throw an error
//   when(mockFirebaseAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
//       .thenThrow(FirebaseAuthException(code: 'user-disabled'));

//   await tester.pumpWidget(
//     MaterialApp(
//       home: loginScreen,
//     ),
//   );

//   // Simula la entrada de datos en los campos de correo electrónico y contraseña
//   await tester.enterText(find.byKey(Key('emailField')), 'disabled@gmail.com');
//   await tester.enterText(find.byKey(Key('passwordField')), 'password');

//   // Simula el toque en el botón de inicio de sesión
//   await tester.tap(find.byKey(Key('signInButton')));

//   // Espera a que se complete la acción de inicio de sesión
//   await tester.pumpAndSettle();

//   // Verifica si se ha llamado a la función de inicio de sesión de FirebaseAuth
//   verify(mockFirebaseAuth.signInWithEmailAndPassword(email: 'disabled@gmail.com', password: 'password')).called(1);

//   // Verifica si se ha mostrado un SnackBar con el mensaje de error correcto
//   expect(find.text('El usuario está deshabilitado.'), findsOneWidget);
//   expect(find.text('No existe usuario con ese correo electrónico.'), findsNothing);
//   expect(find.text('Contraseña incorrecta.'), findsNothing);
// });

