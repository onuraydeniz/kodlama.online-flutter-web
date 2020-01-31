import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:kodlamaonline/Application.dart';
import 'package:kodlamaonline/Sorular.dart';

import 'Anasayfa.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp(){
    final router = Router();
    var usersHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {

      return Sorular(params["id"][0],params["baslik"][0]);
    });
    router.define("/sorular/:id/:baslik", handler: usersHandler);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepPurple[900],

      ),
      home: Anasayfa()
    );
  }
}

