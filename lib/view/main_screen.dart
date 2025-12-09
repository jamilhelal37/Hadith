import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/view/bokhari_muslim.dart';
import 'package:untitled1/helper/assets.dart';
import 'package:untitled1/view/books_sources.dart';
import 'package:untitled1/view/general_search.dart';
import 'package:untitled1/view/hadith_screen.dart';
import 'package:untitled1/view/login_screen.dart';
import 'package:untitled1/view/profile_screen.dart';
import 'package:untitled1/view/advanced_search_page.dart';
import 'package:untitled1/view/wrong_hadiths.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: Drawer(
            elevation: 25,
            width: 250,
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.xmark_circle),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Image(image: AssetImage(Assets.imagesDrawer)),
                  ),

                  Divider(color: Color(0xffd0953b)),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      CupertinoIcons.home,
                      color: Color(0xffca9b2c),
                    ),
                    title: Text(
                      'الرئيسية',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'cairo',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(color: Color(0xffd0953b)),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                    leading: Icon(Icons.person, color: Color(0xffca9b2c)),
                    title: Text(
                      'ملفي الشخصي',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'cairo',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(color: Color(0xffd0953b)),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GeneralSearch(),
                        ),
                      );
                    },
                    leading: Icon(
                      CupertinoIcons.search,
                      color: Color(0xffca9b2c),
                    ),
                    title: Text(
                      'بحث عام',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'cairo',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(color: Color(0xffd0953b)),

                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BokhariMuslim(),
                        ),
                      );
                    },
                    leading: Icon(Icons.menu_book, color: Color(0xffca9b2c)),
                    title: Text(
                      'البخاري و مسلم',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'cairo',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(color: Color(0xffd0953b)),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WrongHadiths(),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.error_outline,
                      color: Color(0xffca9b2c),
                    ),
                    title: Text(
                      'احاديث منتشرة لا تصح',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'cairo',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(color: Color(0xffd0953b)),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                    },
                    leading: Icon(
                      CupertinoIcons.search,
                      color: Color(0xffca9b2c),
                    ),
                    title: Text(
                      'البحث المتقدم',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'cairo',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(color: Color(0xffd0953b)),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.done_outline,
                      color: Color(0xffca9b2c),
                    ),
                    title: Text(
                      'تراجم المحدثين',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'cairo',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(color: Color(0xffd0953b)),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      CupertinoIcons.bookmark_fill,
                      color: Color(0xffca9b2c),
                    ),
                    title: Text(
                      'قائمة المفضلة',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'cairo',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(color: Color(0xffd0953b)),

                  SizedBox(height: 12),

                  SizedBox(height: 12),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 120,
                      height: 60,
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
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      sharedPrf.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Container(
                      width: 120,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Color(0xffca9b2c)),
                        color: Color(0xfffffde8).withAlpha(100),
                      ),
                      child: Center(
                        child: Text(
                          'تسجيل الخروج',
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
                    padding: const EdgeInsets.only(left: 16, top: 8),
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
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HadithScreen(),
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
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BooksSources(),
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
                                'الكتب والمصادر',
                                style: TextStyle(
                                  color: Color(0xffca9b2c),
                                  fontSize: 20,
                                  fontFamily: 'cairo',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
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
      ),
    );
  }
}
