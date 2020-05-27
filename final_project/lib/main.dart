import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sidebar/sidebar_layout.dart';
import 'package:final_project/databaseHelper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final dbHelper = DataBaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SideBarLayout(),
    );
  }
}
