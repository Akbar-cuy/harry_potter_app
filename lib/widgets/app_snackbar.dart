import 'package:flutter/material.dart';

/// Dipasang di MaterialApp agar snackbar tetap tampil walau halaman berpindah
final GlobalKey<ScaffoldMessengerState> messengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showAppSnackbar({
  required String title,
  required String message,
  required bool success,
}) {
  final view = WidgetsBinding.instance.platformDispatcher.views.first;
  final height = view.physicalSize.height / view.devicePixelRatio;

  messengerKey.currentState
    ?..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: success ? Colors.green : Colors.red,
        margin: EdgeInsets.only(bottom: height - 170, left: 12, right: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(message,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
}
