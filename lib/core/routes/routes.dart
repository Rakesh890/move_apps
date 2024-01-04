import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/presentation_imports.dart';

class AppRoutes{

  static const String home = '/home';

  static Route<String>? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage(),maintainState: true);

      default:
        return null;
    }
  }
}