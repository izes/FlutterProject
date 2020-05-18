import 'package:flutter/material.dart';


class DescartesQuotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        backgroundColor: Colors.black87,
        title: Text('Descartes', style: TextStyle(
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
                “If you would be a real seeker after truth, 
                it is necessary that at least once in your 
                life you doubt, as far as possible, all things”
                ― René Descartes
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
              alignment: Alignment(0.8,0),
              child: FloatingActionButton.extended(
                heroTag: "btn1",
                onPressed: null,
                backgroundColor: Colors.redAccent,
                icon: new Icon(Icons.favorite),
                label: Text("4"),
            ),
            ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
              '''
                “If you would be a real seeker after truth, 
                it is necessary that at least once in your 
                life you doubt, as far as possible, all things”
                ― René Descartes
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
              alignment: Alignment(0.8,0),
              child: FloatingActionButton.extended(
                heroTag: "btn2",
                onPressed: null,
                backgroundColor: Colors.redAccent,
                icon: new Icon(Icons.favorite),
                label: Text("2"),
            ),
            ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
              '''
                “If you would be a real seeker after truth, 
                it is necessary that at least once in your 
                life you doubt, as far as possible, all things”
                ― René Descartes
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
              alignment: Alignment(0.8,0),
              child: FloatingActionButton.extended(
                heroTag: "btn3",
                onPressed: null,
                backgroundColor: Colors.redAccent,
                icon: new Icon(Icons.favorite),
                label: Text("8"),
            ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}