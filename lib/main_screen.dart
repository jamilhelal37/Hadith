import 'package:flutter/material.dart';
import 'package:hadith/generated/assets.dart';
import 'package:hadith/search_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffde8),
      body: Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: 80,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(Assets.imagesEdited2),
            ),
          ),
          SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16, top:24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image(image: AssetImage(Assets.imagesPic1)),
                ),
                Text(
                  textAlign: TextAlign.center,
                  ' مرحبا بكم \nفي الموسوعة الحديثية',
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffd0953b),
                  ),
                ),
                SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                  },
                  child: Container(
                    width: 160,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Color(0xffca9b2c)),
                      color: Color(0xfff8dcb8).withAlpha(100),
                    ),
                    child: Center(
                      child: Text(
                        'البحث المتقدم',
                        style: TextStyle(
                          color: Color(0xffca9b2c),
                          fontSize: 20,
                          fontFamily: 'cairo',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 160,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xffca9b2c)),
                    color: Color(0xfff8dcb8).withAlpha(100),
                  ),
                  child: Center(
                    child: Text(
                      'الأحاديث الشريفة',
                      style: TextStyle(
                        color: Color(0xffca9b2c),
                        fontSize: 20,
                        fontFamily: 'cairo',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 160,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xffca9b2c)),
                    color: Color(0xfff8dcb8).withAlpha(100),
                  ),
                  child: Center(
                    child: Text(
                      'الكتب والمصادر',
                      style: TextStyle(
                        color: Color(0xffca9b2c),
                        fontSize: 20,
                        fontFamily: 'cairo',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Spacer(flex: 1),

                Text(
                  '2024 جميع الحقوق محفوظة @ الموسوعة الحديثية ',
                  style: TextStyle(fontSize: 10),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
