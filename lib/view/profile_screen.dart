import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/generated/assets.dart';
import 'package:untitled1/model/user_model.dart';
import '../services/api_services.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Simulate loading delay (remove in production)
    await Future.delayed(Duration(milliseconds: 500));

    // Replace this with your actual API call
    Example: final user = await ApiRepositry().getCurrentUser();

    // For now, let's create a dummy user (replace with your actual user data)
setState(() {
  _user=user;
});
  }

  @override
  Widget build(BuildContext context) {

    if (_user == null) {
      return Scaffold(
        backgroundColor: Color(0xfffffde8),
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:150,width:150,child: Lottie.asset(Assets.imagesLoading1)),
            Center(
              child: Text(textDirection: TextDirection.rtl,
                'الرجاء الانتظار ..',
                style: TextStyle(
                  fontFamily: 'cairo',
                  color: Color(0xffd0953b),
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfffffde8),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesBg3),
            fit: BoxFit.fill,
          ),
        ),
        width: double.infinity,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfffffde8).withAlpha(190),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, right: 12, left: 12),
                  child: Row(
                    children: [
                      Spacer(flex: 2),
                      Text(
                        'الملف الشخصي',
                        style: TextStyle(
                          color: Color(0xffd0953b),
                          fontFamily: 'cairo',
                          fontSize: 23,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Icon(
                            textDirection: TextDirection.ltr,
                            Icons.arrow_back,
                            color: Color(0xffd0953b),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 67,
                  backgroundColor: Color(0xffd0953b),
                  child: Text(
                    _user!.name.isNotEmpty ? _user!.name[0] : '?',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xfffffde8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withAlpha(100),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 266,
                        child: TextFormField(
                          initialValue: _user!.name,
                          readOnly: true,
                          cursorColor: Colors.black.withAlpha(100),
                          decoration: InputDecoration(
                            labelText: "الاسم",
                            labelStyle: TextStyle(
                              color: Color(0xffd0953b),
                              fontSize: 16,
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
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        width: 266,
                        child: TextFormField(
                          initialValue: _user!.username,
                          readOnly: true,
                          cursorColor: Colors.black.withAlpha(100),
                          decoration: InputDecoration(
                            labelText: "اسم المستخدم",
                            labelStyle: TextStyle(
                              color: Color(0xffd0953b),
                              fontSize: 16,
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
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        width: 266,
                        child: TextFormField(
                          initialValue: _user!.email,
                          readOnly: true,
                          cursorColor: Colors.black.withAlpha(100),
                          decoration: InputDecoration(
                            labelText: "البريد الإلكتروني",
                            labelStyle: TextStyle(
                              color: Color(0xffd0953b),
                              fontSize: 16,
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
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        width: 266,
                        child: TextFormField(
                          initialValue: _user!.usertype == 'admin'
                              ? 'مدير'
                              : 'مستخدم',
                          readOnly: true,
                          cursorColor: Colors.black.withAlpha(100),
                          decoration: InputDecoration(
                            labelText: "نوع المستخدم",
                            labelStyle: TextStyle(
                              color: Color(0xffd0953b),
                              fontSize: 16,
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
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
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