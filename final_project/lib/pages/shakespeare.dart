import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class Shakespeare extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Shakespeare', style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: new Container(
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.black, Colors.grey]
          ),
          image: new DecorationImage(
          fit: BoxFit.fill,
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: AssetImage('images/logo.jpeg')
          ),
        ),
        child: Center(
          child: Text("Shakespeare", style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        ),
      ),
    );
  }
}