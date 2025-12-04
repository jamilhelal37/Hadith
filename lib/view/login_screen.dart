import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toastification/toastification.dart';
import 'package:untitled1/controller/outh_cubit/auth_cubit.dart';
import 'package:untitled1/view/sign_up_screen.dart';
import '../model/login_model.dart';
import '../helper/assets.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isClosed = false;
  bool enText = true;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passWordCont = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfffffde8),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is AuthLooding,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.imagesBackground1),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Spacer(),
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image(image: AssetImage(Assets.imagesPic1)),
                        ),
                        SizedBox(height: 8,),
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
                              labelText: 'البريد الالكتروني او الاسم ',
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
                        InkWell(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              bool res=await BlocProvider.of<AuthCubit>(context).login(
                                LoginModel(
                                  email: emailCont.text,
                                  password: passWordCont.text,
                                ),
                              );
                              if (state is AuthSuccess||res) {
                                toastification.show(
                                  context: context,
                                  title: Text('تم تسجيل الدخول '),
                                  autoCloseDuration: const Duration(seconds: 5),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ),
                                );
                              } else if (state is AuthFailed) {
                                toastification.show(
                                  context: context,
                                  title: Text('حدث خطأ'),
                                  autoCloseDuration: const Duration(seconds: 5),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
