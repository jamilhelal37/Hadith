import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      resizeToAvoidBottomInset: false,backgroundColor: Color(0xfffffde8),
      body: SizedBox(
        width: double.infinity,
        child: Directionality(textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30,right: 12,left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xfffffde8),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          color: Color(0xfffffde8),
                          Icons.settings_outlined,
                        ),
                      ),
                    ),
                    Text(
                      'الملف الشخصي',
                      style: TextStyle(
                        color: Color(0xffd0953b),
                        fontFamily: 'cairo',
                        fontSize: 23,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 50,
                        width: 50,

                        child: Icon(textDirection: TextDirection.ltr,Icons.arrow_back, color: Color(0xffd0953b)),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 16),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white.withAlpha(70),
                child: CircleAvatar(radius: 67),
              ),
              SizedBox(height: 24),
              Container(
                height: 380,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xfffffde8),
                  boxShadow: [
                    BoxShadow(blurRadius: 20, color: Colors.black.withAlpha(100)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            Text(
                              'الاسم',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: "cairo",
                                fontSize: 20,
                                color: Color(0xffd0953b),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 130,
                            child: TextFormField(
                              cursorColor: Colors.black.withAlpha(100),
                              decoration: InputDecoration(
                                labelText: "الاول",
                                labelStyle: TextStyle(
                                  color: Colors.black.withAlpha(80),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color(0xffd0953b),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color(0xffd0953b),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: Color(0xffd0953b),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          SizedBox(
                            width: 130,
                            child: TextFormField(
                              cursorColor: Colors.black.withAlpha(100),
                              decoration: InputDecoration(
                                labelText: "الثاني",
                                labelStyle: TextStyle(
                                  color: Colors.black.withAlpha(80),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color(0xffd0953b),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color(0xffd0953b),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: Color(0xffd0953b),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 266,
                        child: TextFormField(
                          cursorColor: Colors.black.withAlpha(100),
                          decoration: InputDecoration(
                            labelText: "الرقم (+963)",
                            labelStyle: TextStyle(
                              color: Colors.black.withAlpha(80),
                            ),
                            suffixIcon: Icon(
                              size: 25,
                              Icons.phone,
                              color: Color(0xffd0953b),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xffaad09d),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 266,
                        child: TextFormField(
                          cursorColor: Colors.black.withAlpha(100),
                          decoration: InputDecoration(
                            labelText: "البريد الالكتروني",
                            labelStyle: TextStyle(
                              color: Colors.black.withAlpha(80),
                            ),
                            suffixIcon: Icon(
                              size: 25,
                              Icons.email,
                              color: Color(0xffd0953b),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xffd0953b),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 266,
                        child: TextFormField(
                          cursorColor: Colors.black.withAlpha(100),
                          decoration: InputDecoration(
                            labelText: "كلمة المرور",
                            labelStyle: TextStyle(
                              color: Colors.black.withAlpha(80),
                            ),
                            suffixIcon: InkWell(
                              onTap: () {},
                              child: Icon(
                                size: 25,
                                CupertinoIcons.eye_slash_fill,
                                color: Color(0xffd0953b),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 3,
                                color: Color(0xffd0953b),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 125,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xffd0953b),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.black.withAlpha(50),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'تم',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Color(0xfffffde8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
