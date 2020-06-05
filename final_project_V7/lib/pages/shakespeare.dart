import 'dart:async';
import 'package:final_project/pages/shakespearequotes.dart';
import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:rect_getter/rect_getter.dart';
import '../models/author.dart';
import 'package:final_project/databaseHelper.dart';
import 'package:flutter/widgets.dart';

class Shakespeare extends StatefulWidget with NavigationStates {
  @override
  _ShakespeareState createState() => _ShakespeareState();
}

class _ShakespeareState extends State<Shakespeare> {
  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  final dbHelper = DataBaseHelper.instance;
  List<Author> shakespeare = new List<Author>();
  final authorShakespeare = 'Shakespeare';

  @override
  void initState() {
    super.initState();
    //Timer.run (() => _insertAuthor());
    WidgetsBinding.instance
        .addPostFrameCallback((_) => queryAuthor(authorShakespeare));
  }

  void _onTap() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: ShakespeareQuotes()))
        .then((_) => setState(() => rect = null));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black87,
            title: Text(
              'Shakespeare',
              style: TextStyle(
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
                  colors: [Colors.black, Colors.grey]),
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.03), BlendMode.dstATop),
                  image: AssetImage('images/logo.jpeg')),
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(top: 60, bottom: 50),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: AssetImage('images/shakespeare.jpg'),
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: 5, maxWidth: 400),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '''
                        Name: ${shakespeare[0].authorName}
                        Born: ${shakespeare[0].authorBirth}
                        Nationality: ${shakespeare[0].authorNationality}
                        Occupation:	${shakespeare[0].authorOccupation}
                        FunFact: ${shakespeare[0].authorFact}
                      ''',
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 160, right: 5),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: RectGetter(
                          key: rectGetterKey,
                          child: FloatingActionButton.extended(
                            onPressed: _onTap,
                            backgroundColor: Color(0xFF14213d),
                            icon: Icon(Icons.mail_outline),
                            label: Text('Quotes'),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
        _ripple(),
      ],
    );
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      ),
    );
  }

  void queryAuthor(name) async {
    final allRows = await dbHelper.queryAuthor(name);
    shakespeare.clear();
    allRows.forEach((row) => shakespeare.add(Author.fromMap(row)));
    setState(() {});
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}
