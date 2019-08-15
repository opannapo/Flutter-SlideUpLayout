import 'package:flutter/material.dart';

import 'views/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        cursorColor: Colors.white,
        canvasColor: Colors.transparent,
        hintColor: Colors.grey,
        unselectedWidgetColor: Colors.grey,
        fontFamily: 'helr45w',
      ),
      //home: new Splash(),
      home: new Home(
        key: GlobalKey(),
      ),
    );
  }
}
