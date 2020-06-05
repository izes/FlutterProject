import 'package:final_project/sidebar/sidebar.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:final_project/databaseHelper.dart';

class HomePage extends StatefulWidget with NavigationStates {
  TextEditingController textController;
  HomePage({this.textController});

  @override
  _HomePageState createState() => _HomePageState(textController);
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController;
  _HomePageState(this.textController);

  final dbHelper = DataBaseHelper.instance;
  List<User> userByName = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text(
          'Thinkers',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: new BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black, Colors.grey]),
          image: new DecorationImage(
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.03), BlendMode.dstATop),
              image: AssetImage('images/logo.jpeg')),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin:
                  new EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
              decoration: BoxDecoration(
                color: new Color.fromARGB(255, 240, 240, 240),
                border: new Border.all(width: 1.2, color: Colors.black12),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(6.0)),
              ),
              child: new TextFormField(
                onChanged: (text) {
                  _queryByName(text.toLowerCase());
                },
                controller: widget.textController,
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
              margin:
                  new EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          if (widget.textController.text.isEmpty == true) {
                            _showMessageScaffold('User cant be null');
                          } else {
                            if (_isNewUser(
                                (widget.textController.text).toLowerCase())) {
                              String userName =
                                  (widget.textController.text).toLowerCase();
                              _insert(userName);
                            } else {
                              _showMessageScaffold('User Validated');
                            }
                          }
                        });
                      },
                      textColor: Colors.white,
                      child:
                          const Text('Submit', style: TextStyle(fontSize: 20)),
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

  void _insert(userName) async {
    Map<String, dynamic> row = {
      DataBaseHelper.colUserName: userName,
    };
    User user = User.fromMap(row);
    final id = await dbHelper.insert(user);
    _showMessageScaffold('User id# $id');
    userByName.add(user);
    setState(() {});
  }

  void _queryByName(name) async {
    final allRows = await dbHelper.queryRows(name);
    userByName.clear();
    allRows.forEach((row) => userByName.add(User.fromMap(row)));
    setState(() {});
  }

  bool _isNewUser(name) {
    for (var i = 0; i < userByName.length; i++) {
      if (userByName[i].userName == name) {
        return false;
      }
    }
    return true;
  }
}
