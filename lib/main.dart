
import 'package:flutter/material.dart';
import 'ui/main_screen.dart';
import 'ui/add_screen.dart';
// import 'ui/contact_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => MainScreen(),
        "/second": (context) => AddScreen()
      },
    );
  }
}

