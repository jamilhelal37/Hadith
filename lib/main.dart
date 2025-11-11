import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:untitled1/splash%20_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:SplashScreen() ,
        ),
    );

  }
}

