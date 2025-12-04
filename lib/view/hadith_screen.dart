import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../helper/assets.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffde8),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              width: 250,
              height: 250,
              Assets.imagesUnderConstruction,
            ),
            SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'Coming Soon !',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.w400,
                  color: Colors.black
                ),
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
