import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:to_do_app_sharedpreferences/util/fonts/app_fonts.dart';
import 'package:to_do_app_sharedpreferences/util/routes/app_routes.dart';
import 'package:to_do_app_sharedpreferences/util/routes/routes.dart';

void main() {
   runApp(const Material(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: ThemeData(fontFamily: AppFonts.primaryFontname),
      initialRoute: RouteName.homePage,
      getPages: AppRoutes.appRoutes(),
    );
  }
}
