import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:untitled1/controller/advanced_search_cubit/advanced_search_cubit.dart';
import 'package:untitled1/controller/fake_hadeth_cubit/fake_hadeth_cubit.dart';
import 'package:untitled1/controller/outh_cubit/auth_cubit.dart';
import 'package:untitled1/controller/register_cubit/register_cubit.dart';
import 'package:untitled1/model/fake_hadeth_model.dart';
import 'package:untitled1/services/advanced_search_repo.dart';
import 'package:untitled1/services/fake_hadeth_repo.dart';
import 'package:untitled1/view/splash%20_screen.dart';


late SharedPreferences sharedPrf;

void main() async {
SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  statusBarColor: Colors.grey,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  systemStatusBarContrastEnforced: true
));
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrf = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   // print(FakeHadethRepo().getFakeHadeth());
    return ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => RegisterCubit()),
          BlocProvider(create: (context) => AdvancedSearchCubit(AdvancedSearchRepository())),
          BlocProvider(create: (context) => FakeHadethCubit(),)
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
