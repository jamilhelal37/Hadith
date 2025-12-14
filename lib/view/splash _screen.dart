import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/view/login_screen.dart';
import 'package:untitled1/view/main_screen.dart';
import '../helper/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>
       sharedPrf.getString('isLogin')==null? LoginScreen():MainScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffde8),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: Image(image: AssetImage(Assets.imagesPic1)),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: 90,
                height: 90,
                child: LottieBuilder.asset('assets/images/Loading (1).json'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
