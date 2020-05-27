import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:final_project/databaseHelper.dart';

class HomePage extends StatefulWidget with NavigationStates{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DataBaseHelper.instance;
  List<User> user = [];

  //Insert Controller
  TextEditingController userNameController = TextEditingController();

  //Query controller
  TextEditingController queryController = TextEditingController();
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  void _showMessageScaffold(String message){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(message),
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
                controller: userNameController,
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
                    onPressed: () {
                      String userName = userNameController.text;
                      _insert(userName);
                    },
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

  void _insert(userName) async {
    Map<String, dynamic> row = {      
      DataBaseHelper.colUserName: userName,
    };
    User user =  User.fromMap(row);
    final id = await dbHelper.insert(user);
    _showMessageScaffold('User id# $id');
  }
}
