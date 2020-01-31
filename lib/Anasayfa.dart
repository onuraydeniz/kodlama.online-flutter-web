import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kodlamaonline/SoruCevap.dart';

import 'AnasayfaIcerikler.dart';
import 'extensions/hoverExtension.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  final List<String> basliklar = [
    'Anasayfa',
    'Soru-Cevap',
    'Geyik',
    'İş Arayanlar',
    'Projeler',
    'Takım Oluştur'
  ];
  var suankiSayfa = 0;
  final List<Widget> sayfalar = [AnasayfaIcerikler(), SoruCevap()];
  final Widget logo = Image.asset(
    'logo.png',
    height: 50,
  );
  List<Widget> icerikList = List<Widget>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    bool screenMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      key: _scaffoldKey,
        drawer: screenMobile
            ? Drawer(
                child: Container(
                    color: Colors.deepPurple[900], child: solMenu(true)),
              )
            : null,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: screenMobile ? 100 :0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  Expanded(
                    child: logo,
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      width: screenMobile ? 0 : MediaQuery.of(context).size.width / 5,
                      color: Colors.deepPurple[900],
                      child: solMenu(false)),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      color: Colors.deepPurple[900],
                      child: SingleChildScrollView(child: sayfalar[suankiSayfa]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget solMenuChild(String text, bool mobile) {
    return GestureDetector(
      onTap: () {
        if (basliklar[0] == text) {
          setState(() {
            _scaffoldKey.currentState.openEndDrawer();
            suankiSayfa = 0;
          });
        } else if (basliklar[1] == text) {
          setState(() {
            _scaffoldKey.currentState.openEndDrawer();
            suankiSayfa = 1;
          });
        } else if (basliklar[2] == text) {
        } else if (basliklar[3] == text) {
        } else if (basliklar[4] == text) {
        } else if (basliklar[5] == text) {}
      },
      child: Card(
        color: Colors.white.withAlpha(10),
        clipBehavior: Clip.antiAlias,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / (mobile ? 2 : 6),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )),
      ).showCursorOnHover,
    );
  }

  Widget solMenu(bool mobile) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: logo,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              solMenuChild(basliklar[0], mobile),
              solMenuChild(basliklar[1], mobile),
              solMenuChild(basliklar[2], mobile),
              solMenuChild(basliklar[3], mobile),
              solMenuChild(basliklar[4], mobile),
              solMenuChild(basliklar[5], mobile),
            ],
          )),
        ],
      );
}
