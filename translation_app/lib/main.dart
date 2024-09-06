import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translation_app/features/saved_words/pages/saved_words_page.dart';
import 'package:translation_app/home.dart';
import 'package:translation_app/util/constants.dart';

import 'features/auth/pages/auth_page.dart';
import 'features/home/pages/home_page.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<int, Color> color = {
    50: AppColors.accent.withOpacity(.1),
    100: AppColors.accent.withOpacity(.2),
    200: AppColors.accent.withOpacity(.3),
    300: AppColors.accent.withOpacity(.4),
    400: AppColors.accent.withOpacity(.5),
    500: AppColors.accent.withOpacity(.6),
    600: AppColors.accent.withOpacity(.7),
    700: AppColors.accent.withOpacity(.8),
    800: AppColors.accent.withOpacity(.9),
    900: AppColors.accent.withOpacity(1),
  };

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          title: 'We can translate everything',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: MaterialColor(AppColors.accent.value, color),
          ),
          home: AuthPage(),
          routes: {
            '/home': (context) => const Home(),
            '/translation': (context) => const MainScreen(),
            '/fav-words': (context) => SavedWordPage(),
            '/auth': (context) => const AuthPage(),
            // '/welcome': (context) => const WelcomePage()
          },
        );
      },
      designSize: Size(360, height),
    );
  }
}
