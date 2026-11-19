import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/character_page.dart';
import 'pages/login_page.dart';
import 'services/notification_service.dart';
import 'widgets/app_snackbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('favorites');
  await NotificationService.init();

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harry Potter App',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: messengerKey,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFFEF7FF),
      ),
      home: isLoggedIn ? const CharacterPage() : const LoginPage(),
    );
  }
}
