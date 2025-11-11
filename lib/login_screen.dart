import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:untitled1/sign_up_screen.dart';
import 'api/models.dart';
import 'api/login_repo.dart';
import 'generated/assets.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isClosed = false;
  int x = 0;
  bool enText = true;
  bool isLoading = false;
  TextEditingController emailCont = TextEditingController();

  TextEditingController passWordCont = TextEditingController();

  final AuthRepository _repo = AuthRepository();
  final formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    setState(() => isLoading = true);

    final loginModel = LoginModel(
      email: emailCont.text,
      password: passWordCont.text,
    );

    final success = await _repo.login(loginModel);

    setState(() => isLoading = false);

    if (success) {
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text('تم تسجيل الدخول '),
        autoCloseDuration: const Duration(seconds: 5),
      );
      x = 1;
    } else {
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text('حدث خطأ'),
        autoCloseDuration: const Duration(seconds: 5),
      );
      x = 0;
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
                            if (!emailCont.text.contains('@') &&
                                emailCont.text.length < 2) {
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
                              return 'Too Short Password';
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
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
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
                      SizedBox(height: 24),
                      isLoading
                          ? CircularProgressIndicator()
                          : InkWell(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  _login();
                                  if (x == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainScreen(),
                                      ),
                                    );
                                  }
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
