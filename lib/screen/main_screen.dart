import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mission_attendant_app/screen/home_screen.dart';
import 'package:mission_attendant_app/screen/logics/theme_logic.dart';
import 'package:mission_attendant_app/screen/login_screen.dart';
import 'package:mission_attendant_app/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int themeIndex = context.watch<ThemeLogic>().themeIndex;
    return MaterialApp(
        themeMode: themeIndex ==1 ? ThemeMode.dark : themeIndex ==2 ? ThemeMode.light : ThemeMode.system,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        // home: HomeScreen(),
        // home: SecondScreen(),
        // home:ThirdScreen(),
        // home: LayoutScreen(),
        // home: FoodScreen(),
        home: LoginScreen(),


        // initialRoute: "/",
        // onGenerateRoute: (settings) {
        //   switch (settings.name) {
        //     case "/":
        //       return CupertinoPageRoute(builder: (context) => MainScreen());
        //     case "/food-detail":
        //     // return CupertinoPageRoute(
        //     //   builder: (context) => DetailScreen(),
        //     //   fullscreenDialog: true,
        //     //   settings: settings,
        //     // );
        //       return PageTransition(
        //         type: PageTransitionType.sharedAxisHorizontal,
        //         childCurrent: this as Widget,
        //         child: DetailScreen(),
        //         settings: settings,
        //         duration: Duration(milliseconds: 300),
        //         reverseDuration: Duration(milliseconds: 300),
        //         fullscreenDialog: true,
        //       );
        //     default:
        //       return CupertinoPageRoute(
        //         builder: (context) =>
        //             Scaffold(
        //               appBar: AppBar(title: Text("Page Not Found")),
        //               body: Center(child: Text("Route might be wrong")),
        //             ),
        //         fullscreenDialog: true,
        //         settings: settings,
        //       );
        //   }
        // }

    );
  }
}