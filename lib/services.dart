import 'dart:async';

class FakeDatabase {
  Future<Map<String, String>> fetchUserData() async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'id': '123',
      'name': 'Walid Arbaoui',
      'email': 'walidarbaoui.fg@gmail.com'
    };
  }

  Stream<String> fetchNotifications() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield 'Notification $i';
    }
  }
}
