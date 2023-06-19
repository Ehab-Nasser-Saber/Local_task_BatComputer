import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:login_counter/auth/views/sign_in_view.dart';

import 'core/color/colors.dart';
import 'core/shared_preference/sharedpref_helper.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: primaryColor,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlobalLoaderOverlay(
      overlayColor: primaryColor,
      useDefaultLoading: false,
      overlayWidget: Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: SignInView()),
    );
  }
}
