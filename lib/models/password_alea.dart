import 'dart:math';

class PasswordGenerator {
  List<String> generatedPasswords = [];

  String generatePassword(int length) {
    String password = _generateRandomPassword(length);

    while (generatedPasswords.contains(password)) {
      password = _generateRandomPassword(length);
    }

    generatedPasswords.add(password);
    return password;
  }

  String _generateRandomPassword(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
  }
}
