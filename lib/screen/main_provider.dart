import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'logics/theme_logic.dart';
import 'package:provider/provider.dart';

Widget MainProvider() {
  return MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ThemeLogic())],
    child: SplashScreen(),
  );
}