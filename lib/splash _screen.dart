import 'package:flutter/material.dart';
import 'package:hadith/sign_up_screen.dart';
import 'generated/assets.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
            (route) => false,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffde8),
      body: SizedBox(width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: Image(image: AssetImage(Assets.imagesPic1)),
              ),
              SizedBox(height: 8,),
              CircularProgressIndicator(color: Color(0xfffffde8)),

            ],
          ),
        ),
      ),
    );
  }
}
