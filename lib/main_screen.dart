import 'package:flutter/material.dart';
import 'package:untitled1/generated/assets.dart';
import 'package:untitled1/hadith_screen.dart';
import 'package:untitled1/search_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Directionality(
        textDirection: TextDirection.rtl,
        child: Drawer(
          elevation: 25,
          width: 250,
          backgroundColor: Color(0xfff8dcb8),
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Color(0xfffffde8)),
                child: Text('\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t'),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 200, height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xffca9b2c)),
                    color: Color(0xfffffde8).withAlpha(100),
                  ),
                  child: Center(
                    child: Text(
                      'ملفي الشخصي',
                      style: TextStyle(
                        color: Color(0xffca9b2c),
                        fontSize: 18,
                        fontFamily: 'cairo',
                      ),
                    ),
                  ),
                ),
              ),
             SizedBox(height: 12,),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 200, height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xffca9b2c)),
                    color: Color(0xfffffde8).withAlpha(100),
                  ),
                  child: Center(
                    child: Text(
                      'قائمة المفضلة',
                      style: TextStyle(
                        color: Color(0xffca9b2c),
                        fontSize: 18,
                        fontFamily: 'cairo',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Divider(color: Color(0xffd0953b),),
              SizedBox(height: 12,),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 120, height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xffca9b2c)),
                    color: Color(0xfffffde8).withAlpha(100),
                  ),
                  child: Center(
                    child: Text(
                      'الاعدادات',
                      style: TextStyle(
                        color: Color(0xffca9b2c),
                        fontSize: 18,
                        fontFamily: 'cairo',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12,),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 120, height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xffca9b2c)),
                    color: Color(0xfffffde8).withAlpha(100),
                  ),
                  child: Center(
                    child: Text(
                      'عن التطبيق',
                      style: TextStyle(
                        color: Color(0xffca9b2c),
                        fontSize: 18,
                        fontFamily: 'cairo',
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      backgroundColor: Color(0xfffffde8),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: double.infinity,
                  width: 80,
                  child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage(Assets.imagesEdited2),
                  ),
                ),
                Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 24),
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
                            MaterialPageRoute(
                              builder: (context) => SearchPage(),
                            ),
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
                      InkWell(onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => HadithScreen(),));
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
                              'الأحاديث الشريفة',
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
                        '2025 جميع الحقوق محفوظة @ الموسوعة الحديثية',
                        style: TextStyle(fontSize: 10),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffca9b2c)),
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xfff8dcb8),
                          ),
                          child: Icon(Icons.menu, color: Color(0xffd0953b)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
