import 'package:get/get.dart';
import 'package:to_do_app_sharedpreferences/pages/add_note.dart';
import 'package:to_do_app_sharedpreferences/pages/home_page.dart';
import 'package:to_do_app_sharedpreferences/util/routes/app_routes.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(name: RouteName.homePage, page: () => const HomePage()),
        GetPage(name: RouteName.notePage, page: () => AddNotePage()),
      ];
}
