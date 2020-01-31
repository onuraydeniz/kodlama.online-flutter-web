import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sorular extends StatelessWidget {
  String id;
  String baslik;
  Sorular(this.id,this.baslik);
  Color metinRenk=Color.fromRGBO(255, 255, 255, 0.9);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
                flightShuttleBuilder: _flightShuttleBuilder,
                tag: 'baslik'+id.toString(),
                child: Text(baslik,textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Text('Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500\'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960\'larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.',
              style: TextStyle(color: metinRenk)),
            ),
            Text('Soru id:$id',style: TextStyle(color: metinRenk))
          ],
        ),
      ),
    );
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
