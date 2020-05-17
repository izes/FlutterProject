import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text('Thinkers', style: TextStyle(
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
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.03), BlendMode.dstATop),
          image: AssetImage('images/logo.jpeg')
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(left:20.0, right: 20.0, bottom: 15.0),
              decoration: BoxDecoration(
                color: new Color.fromARGB(255,240,240,240),
                border: new Border.all(width: 1.2, color: Colors.black12),
                borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
              ),
              child: new TextFormField(
                decoration: InputDecoration(
                hintText: 'Enter your username',
                contentPadding: new EdgeInsets.all(10.0),
                border: InputBorder.none,
            ),
          ),
        ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF000000),
                  Color(0xFFCCCCCC),
                  Color(0xFFFFFFFF),
                ],
              ),
            ),
            margin: new EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: RaisedButton(
                    onPressed: () {},
                    textColor: Colors.white,
                    child: const Text('Submit', style: TextStyle(fontSize: 20)),
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}