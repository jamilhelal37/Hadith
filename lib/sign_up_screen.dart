import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/main_screen.dart';

import 'generated/assets.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isClosed = false;
  bool enText = true;
  DateTime? _selectedDate;
  TextEditingController dateController = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passWordCont = TextEditingController();
  TextEditingController confCont = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

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
                        'انشئ حسابك',
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
                          controller: nameCont,
                          validator: (val) {
                            if (nameCont.text.length < 2) {
                              return "invalid name";
                            }
                            return null;
                          },
                          textAlign: TextAlign.right,
                          cursorColor: Color(0xffd0953b),
                          decoration: InputDecoration(
                            labelText: 'الاسم',
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: passWordCont,
                          validator: (val) {
                            if (passWordCont.text.length < 6) {
                              return "password most be greater than 8 ";
                            }
                            return null;
                          },
                          obscureText: enText,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          cursorColor: Color(0xffd0953b),
                          decoration: InputDecoration(
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  enText = enText ? false : true;
                                  isClosed = isClosed ? false : true;
                                });
                              },
                              child: Icon(
                                color: Color(0xffd0953b),
                                isClosed
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
                              ),
                            ),
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
                      SizedBox(height: 20),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: confCont,
                          validator: (val) {
                            if (confCont.text.isEmpty||confCont.text != passWordCont.text) {
                              return "wrong password";
                            }
                            return null;
                          },
                          obscureText: enText,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          cursorColor: Color(0xffd0953b),
                          decoration: InputDecoration(
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  enText = enText ? false : true;
                                  isClosed = isClosed ? false : true;
                                });
                              },
                              child: Icon(
                                color: Color(0xffd0953b),
                                isClosed
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
                              ),
                            ),
                            labelText: 'تأكيد كلمة المرور',
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
                      SizedBox(height: 20),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          controller: dateController,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'please select your date';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today,color: Color(0xffd0953b),),
                            labelText: 'تاريخ الميلاد',
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
                          readOnly: true,
                          onTap: () => _selectDate(context),
                        ),
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'هل لديك حساب بالفعل؟',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
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
                              'إنشاء',
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
