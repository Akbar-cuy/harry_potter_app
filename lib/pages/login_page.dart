import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/app_snackbar.dart';
import 'character_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userC = TextEditingController();
  final _passC = TextEditingController();

  // Logika login hardcoded
  static const _validUser = 'admin';
  static const _validPass = 'admin123';

  Future<void> _login() async {
    if (_userC.text.trim() == _validUser && _passC.text == _validPass) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const CharacterPage()),
      );
      showAppSnackbar(
          title: 'Success!',
          message: 'Logged in Successfully',
          success: true);
    } else {
      showAppSnackbar(
          title: 'Failed!',
          message: 'Username or password is incorrect',
          success: false);
    }
  }

  @override
  void dispose() {
    _userC.dispose();
    _passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Login',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _userC,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passC,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonal(
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
