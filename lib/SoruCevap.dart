import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodlamaonline/Sorular.dart';
import 'package:kodlamaonline/models/SoruBlok.dart';
import 'Application.dart';
import 'models/Soru.dart';
import 'extensions/hoverExtension.dart';

class SoruCevap extends StatefulWidget {
  @override
  _SoruCevapState createState() => _SoruCevapState();
}

class _SoruCevapState extends State<SoruCevap> {
  bool sorusor = false;
  TextEditingController baslikTect = TextEditingController();

  List<SoruBlok> yeniSoruWigetlar = [
    SoruBlok(
        "aciklama",
        TextField(
          controller: TextEditingController(),
          decoration: InputDecoration(
              fillColor: Colors.deepOrange, hintText: 'Açıklama yazınız'),
        ))
  ];

  @override
  Widget build(BuildContext context) {
    double solmenugenislik = MediaQuery.of(context).size.width / 5;
    double tamgenislik = MediaQuery.of(context).size.width;
    bool screenMobile = MediaQuery.of(context).size.width < 700;

    final _formKey = GlobalKey<FormState>();

    return FutureBuilder(
      future: get(),
      builder: (BuildContext context, AsyncSnapshot veri) {
        if (veri.hasData) {
          List<Soru> liste = veri.data;
          return Column(
            children: <Widget>[
              RaisedButton.icon(
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    sorusor = !sorusor;
                  });
                },
                icon: Icon(sorusor ? Icons.cancel : Icons.add),
                label: Text('Soru Sor'),
              ).showCursorOnHover,
              AnimatedContainer(
                color: Colors.white,
                curve: Curves.easeInOutCirc,
                duration: Duration(milliseconds: 500),
                width: tamgenislik,
                height: sorusor ? 450 : 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            TextFormField(
                              controller: baslikTect,
                              cursorColor: Colors.deepPurple,
                              decoration: InputDecoration(
                                hintText: 'Başlık',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Lütfen bir başlık girin';
                                }
                                return null;
                              },
                            ),
                          ])),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            width: 100,
                            child: Column(
                              children: <Widget>[
                                RaisedButton.icon(
                                    animationDuration:
                                        Duration(milliseconds: 100),
                                    color: Colors.deepPurple,
                                    onPressed: () {
                                      setState(() {
                                        yeniSoruWigetlar.add(
                                            metinBlok(TextEditingController()));
                                      });
                                    },
                                    icon: Icon(
                                      Icons.text_fields,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Metin',
                                      style: TextStyle(color: Colors.white),
                                    )).showCursorOnHover,
                                RaisedButton.icon(
                                    animationDuration:
                                        Duration(milliseconds: 100),
                                    color: Colors.deepPurple,
                                    onPressed: () {
                                      setState(() {
                                        yeniSoruWigetlar.add(
                                            kodBlok(TextEditingController()));
                                      });
                                    },
                                    icon: Icon(
                                      Icons.code,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Kod',
                                      style: TextStyle(color: Colors.white),
                                    )).showCursorOnHover
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 300,
                              margin: EdgeInsets.only(left: 16.0, right: 16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: yeniSoruWigetlar.map((widget) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: widget.textfield,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      RaisedButton.icon(
                        animationDuration: Duration(milliseconds: 100),
                        color: Colors.deepPurple,
                        onPressed: () {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState.validate()) {

                            soruEkle();

                          }

                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Gönder',
                          style: TextStyle(color: Colors.white),
                        ),
                      ).showCursorOnHover
                    ],
                  ),
                ),
              ),
              Wrap(
                children: liste
                    .map((Soru soru) => GestureDetector(
                          onTap: () {

                            Application.router.navigateTo(context,"sorular/${soru.id}/${soru.baslik}" ,transitionDuration: Duration(seconds: 2));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: (tamgenislik - (solmenugenislik)) / (screenMobile ? 1 : 2) -
                                      40,
                                  height: 60,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 60,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 30,
                                              height: 30,
                                              clipBehavior: Clip.antiAlias,
                                              child: Image.asset(
                                                soru.resim,
                                              ),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle),
                                            ),
                                            Expanded(
                                              child: Hero(
                                                flightShuttleBuilder:
                                                    _flightShuttleBuilder,
                                                tag: 'baslik${soru.id}',
                                                child: Text(
                                                  soru.baslik,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ).showCursorOnHover,
                          ),
                        ))
                    .toList(),
              ),
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Future<List<Soru>> get() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Soru(
          0,
          'Await ve then arasındaki fark nedir?',
          '17.jpg',
          '10 Dakika önce',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
      Soru(1, 'Kodu 1 saniye nasıl bekletebilirim?', '40.jpg', '1 Saat önce',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
      Soru(2, 'Flutter header gönderme', '67.jpg', '2 Saat önce',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
      Soru(3, 'Flutter web servislere veri gönderme', '73.jpg', '3 Saat önce',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
      Soru(
          4,
          'Await ve then arasındaki fark nedir?',
          '17.jpg',
          '10 Dakika önce',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
      Soru(5, 'Kodu 1 saniye nasıl bekletebilirim?', '40.jpg', '1 Saat önce',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
      Soru(6, 'Flutter header gönderme', '67.jpg', '2 Saat önce',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
      Soru(7, 'Flutter web servislere veri gönderme', '73.jpg', '3 Saat önce',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.')
    ];
  }

  void soruEkle() {
    yeniSoruWigetlar.forEach((sorublok) {
      print(sorublok.textfield.controller.text + "tip:${sorublok.tip}");
    });
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Sorunuz eklendi.Soru=${baslikTect.text}')));
  }

  SoruBlok metinBlok(TextEditingController tec) {
    return SoruBlok(
        "aciklama",
        TextField(
          controller: tec,
          decoration: InputDecoration(
              fillColor: Colors.deepOrange, hintText: 'Açıklama yazınız'),
        ));
  }

  SoruBlok kodBlok(TextEditingController tec) {
    return SoruBlok(
        "kod",
        TextField(
          controller: tec,
          decoration: InputDecoration(hintText: 'Kodunuzu yazınız'),
        ));
  }

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }
}
