import 'package:mix_tube_application/contants/route_name.dart';
import 'package:mix_tube_application/pages/home_page/home_page.dart';
import 'package:mix_tube_application/pages/login_page/login_page.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouterName.HOME_PAGE:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case RouterName.LOGIN_PAGE:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    default:
      return MaterialPageRoute(builder: (context) => const HomePage());
  }
}
