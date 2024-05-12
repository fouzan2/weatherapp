import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:weatherapp/screens/Onboarding_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(
    const Duration(seconds: 3),
  );
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
        ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(
              0, 16, 247, 1
          ),
        ),
        useMaterial3: true,
      ),
      home: OnboardingPage(),
    );
  }
}

