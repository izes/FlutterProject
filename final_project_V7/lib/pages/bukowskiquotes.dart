import 'dart:async';
import 'package:final_project/models/quote.dart';
import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:final_project/databaseHelper.dart';
import 'package:flutter/widgets.dart';

class BukowskiQuotes extends StatefulWidget {
  BukowskiQuotes({Key key}) : super(key: key);
  TextEditingController textController;

  @override
  _BukowskiQuotesState createState() => _BukowskiQuotesState();
}

class _BukowskiQuotesState extends State<BukowskiQuotes> {
  TextEditingController textController;

  final dbHelper = DataBaseHelper.instance;
  List<Quote> bukowskiQuote = new List<Quote>();
  final bukowskiquote = '1';

  bool likeQ1 = false;
  bool likeQ2 = false;
  bool likeQ3 = false;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => queryQuote(bukowskiquote));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black87,
        title: Text(
          'Bukowski',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
        ),
        child: new ListView(
          padding: const EdgeInsets.all(5),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                '''
                ${bukowskiQuote[0].quoteName}
              ''',
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: Align(
                alignment: Alignment(0.8, 0),
                child: FloatingActionButton.extended(
                  heroTag: "btn1",
                  label: Text('${bukowskiQuote[0].quoteLike}'),
                  onPressed: () {
                    setState(() {
                      if (likeQ1 == true) {
                        bukowskiQuote[0].quoteLike--;
                        likeQ1 = false;
                        _update(bukowskiQuote[0]);
                      } else {
                        bukowskiQuote[0].quoteLike++;
                        likeQ1 = true;
                        _update(bukowskiQuote[0]);
                      }
                    });
                  },
                  backgroundColor: Colors.deepPurple[800],
                  icon: new Icon(
                      likeQ1 ? Icons.favorite : Icons.favorite_border,
                      color: likeQ1 ? Colors.red : Colors.grey),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                '''
                ${bukowskiQuote[1].quoteName}
              ''',
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: Align(
                alignment: Alignment(0.8, 0),
                child: FloatingActionButton.extended(
                  heroTag: "btn2",
                  onPressed: () {
                    setState(() {
                      if (likeQ2 == true) {
                        bukowskiQuote[1].quoteLike--;
                        likeQ2 = false;
                        _update(bukowskiQuote[1]);
                      } else {
                        bukowskiQuote[1].quoteLike++;
                        likeQ2 = true;
                        _update(bukowskiQuote[1]);
                      }
                    });
                  },
                  backgroundColor: Colors.deepPurple[800],
                  icon: new Icon(
                      likeQ2 ? Icons.favorite : Icons.favorite_border,
                      color: likeQ2 ? Colors.red : Colors.grey),
                  label: Text('${bukowskiQuote[1].quoteLike}'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                '''
                ${bukowskiQuote[2].quoteName}
              ''',
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: Align(
                alignment: Alignment(0.8, 0),
                child: FloatingActionButton.extended(
                  heroTag: "btn3",
                  onPressed: () {
                    setState(() {
                      if (likeQ3 == true) {
                        bukowskiQuote[2].quoteLike--;
                        likeQ3 = false;
                        _update(bukowskiQuote[2]);
                      } else {
                        bukowskiQuote[2].quoteLike++;
                        likeQ3 = true;
                        _update(bukowskiQuote[2]);
                      }
                    });
                  },
                  backgroundColor: Colors.deepPurple[800],
                  icon: new Icon(
                      likeQ3 ? Icons.favorite : Icons.favorite_border,
                      color: likeQ3 ? Colors.red : Colors.grey),
                  label: Text('${bukowskiQuote[2].quoteLike}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _update(Quote quote) async {
    final id = await dbHelper.updateLike(quote);
    print('id updated $id');
  }

  void queryQuote(authorid) async {
    final allRows = await dbHelper.queryQuote(authorid);
    bukowskiQuote.clear();
    allRows.forEach((row) => bukowskiQuote.add(Quote.fromMap(row)));
    setState(() {});
  }
}
