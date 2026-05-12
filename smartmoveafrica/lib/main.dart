import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeAppServices();
  runApp(const ProviderScope(child: SmartMoveApp()));
}

Future<void> _initializeAppServices() async {
  // Placeholder for Firebase and notification bootstrap in mock-first mode.
  await Future<void>.delayed(const Duration(milliseconds: 30));
}
