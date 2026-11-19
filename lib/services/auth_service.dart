import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/login_page.dart';
import '../widgets/app_snackbar.dart';

class AuthService {
  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
    showAppSnackbar(
        title: 'Success!', message: 'Logged out Successfully', success: true);
  }
}
