import 'package:flutter/material.dart';
import 'package:todoapidemo/screens/add_page.dart';
import 'package:todoapidemo/screens/create.dart';
import 'package:todoapidemo/screens/home.dart';
import 'package:todoapidemo/screens/splash.dart';
import 'package:todoapidemo/utils/notification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that plugins are initialized before runApp
   Notifications.initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( title: 'Flutter Demo',
debugShowCheckedModeBanner: false,
theme: ThemeData.dark(),
        routes: {
          '/': (context) => SplashScreen(),
          '/open': (context) => CustomScreen(),
          // Task screen route
          '/home': (context) => TodoListPage(),
          '/todo':(context) => AddTodoPage()// Home screen route
        },

    );
  }
}

