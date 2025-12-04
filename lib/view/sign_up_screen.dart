import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toastification/toastification.dart';
import 'package:untitled1/controller/register_cubit/register_cubit.dart';
import 'package:untitled1/controller/register_cubit/register_state.dart';
import 'package:untitled1/model/regester_model.dart';
import '../helper/assets.dart';

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
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
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
        body: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is RegisterLooding,
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

                        SizedBox(
                          height: 400,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
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
                                      if (!emailCont.text.contains(
                                        '@gmail.com',
                                      )) {
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
                                      if (confCont.text.isEmpty ||
                                          confCont.text != passWordCont.text) {
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
                                      suffixIcon: Icon(
                                        Icons.calendar_today,
                                        color: Color(0xffd0953b),
                                      ),
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
                              ],
                            ),
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
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              final RegesterModel model = RegesterModel(
                                name: nameCont.text,
                                gender: "male",
                                date: dateController.text,
                                password: passWordCont.text,
                                email: emailCont.text,
                              );

                              var res = await BlocProvider.of<RegisterCubit>(
                                context,
                              ).register(model);
                              if (state is RegisterSuccess || res) {
                                toastification.show(
                                  context: context,
                                  title: Text('تم انشاء الحساب '),
                                  autoCloseDuration: const Duration(seconds: 5),
                                );
                                Navigator.pop(context);
                              } else {
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
              ),
            );
          },
        ),
      ),
    );
  }
}
