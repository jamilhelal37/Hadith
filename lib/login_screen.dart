import 'package:flutter/material.dart';

import 'generated/assets.dart';
import 'main_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailCont = TextEditingController();
  TextEditingController passWordCont = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfffffde8),
        body: SizedBox(
          height: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  SizedBox(
                    width: 100,
                    height: 200,
                    child: Image(image: AssetImage(Assets.imagesEdited3)),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  SizedBox(
                    width: 100,
                    height: 200,
                    child: Image(image: AssetImage(Assets.imagesEdited4)),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    width: 200,
                    height: 100,
                    child: Image(image: AssetImage(Assets.imagesEdited5)),
                  ),
                ],
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Image(image: AssetImage(Assets.imagesPic1)),
                      ),
                      Text(
                        'سجل الدخول',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'cairo',
                          color: Color(0xffd0953b),
                        ),
                      ),
                      SizedBox(height: 24),

                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: emailCont,
                          validator: (val) {
                            if (!emailCont.text.contains('@gmail.com')) {
                              return 'invalid email';
                            }
                            return null;
                          },
                          textAlign: TextAlign.right,
                          cursorColor: Color(0xffd0953b),
                          decoration: InputDecoration(
                            labelText: 'البريد الالكتروني',
                            floatingLabelAlignment:
                            FloatingLabelAlignment.center,
                            labelStyle: TextStyle(
                              fontFamily: 'cairo',
                              color: Color(0xffd0953b),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: passWordCont,
                          validator: (val) {
                            if (val!.length < 7) {
                              return 'invalid password';
                            }
                            return null;
                          },
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          cursorColor: Color(0xffd0953b),
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            floatingLabelAlignment:
                            FloatingLabelAlignment.center,
                            labelStyle: TextStyle(
                              fontFamily: 'cairo',
                              color: Color(0xffd0953b),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xffd0953b),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'انشاء حساب جديد',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      InkWell(
                        onTap: () {
                          if(formKey.currentState!.validate()){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 200,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xffd0953b),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              'تسجيل',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(flex: 2),
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
