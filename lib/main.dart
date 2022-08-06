import 'package:admin_panel_take_it/controllers/men_controller.dart';
import 'package:admin_panel_take_it/controllers/navigation_controller.dart';
import 'package:admin_panel_take_it/layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC66sCLAVET8WoMqzK7xiI23O_k6Qn_BHg",
          authDomain: "take-it-and-go-fdbc4.firebaseapp.com",
          projectId: "take-it-and-go-fdbc4",
          storageBucket: "take-it-and-go-fdbc4.appspot.com",
          messagingSenderId: "451348502324",
          appId: "1:451348502324:web:3e81ccae025944c1933761"),
    );
  } else {
    Firebase.initializeApp();
  }

  Get.put(MenuController());
  Get.put(NavigationController());

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dash",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primaryColor: Colors.blue,
      ),
      home: SiteLayout(),
    );
  }
}
