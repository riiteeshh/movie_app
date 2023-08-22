import 'package:flutter/material.dart';
import 'package:movie_app/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.mainLayoutPage,
      onGenerateRoute: RouteManager.generateRoute,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          backgroundColor: Colors.white.withOpacity(0),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 0,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            backgroundColor: Colors.transparent,
            showUnselectedLabels: true,
            enableFeedback: false,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.amber),
        navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: MaterialStatePropertyAll(TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
          indicatorColor: Colors.amber,
        ),
      ),
    );
  }
}
