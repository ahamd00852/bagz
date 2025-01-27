import 'package:bagz/features/home/data/data_source/firestore_service.dart';
import 'package:bagz/features/home/presentation/bloc/bagz_bloc.dart';
import 'package:bagz/features/home/presentation/pages/home_page.dart';
import 'package:bagz/features/login/pages/login_page.dart';
import 'package:bagz/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/login/pages/register_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  NotificationService.listen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(410, 823),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) =>
      MaterialApp(
        home: const LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
