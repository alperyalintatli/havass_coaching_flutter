import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/constans/constants.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/aims_provider.dart';
import 'package:provider/provider.dart';

class AimsListWidget extends StatelessWidget {
  AimsProvider _aimsProvider;

  List<Widget> aimList() {
    List<Widget> _widgetlist = List<Widget>();
    int aimsLength = (_aimsProvider.lang == 'en')
        ? Constants.aimsEN.length
        : Constants.aimsDE.length;
    for (var i = 0; i < aimsLength; i++) {
      var _widget = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                color: Colors.grey.withOpacity(0.5))
          ],
          image: DecorationImage(
              image: AssetImage("images/back_0.png"), fit: BoxFit.fill),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(154, 206, 207, 1),
                Color.fromRGBO(24, 231, 239, 1),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                (_aimsProvider.lang == 'en')
                    ? Constants.aimsEN[i]
                    : Constants.aimsDE[i],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      );
      _widgetlist.add(_widget);
    }
    return _widgetlist;
  }

  @override
  Widget build(BuildContext context) {
    _aimsProvider = Provider.of<AimsProvider>(context);
    return CarouselSlider(
      options: CarouselOptions(
        height: 150.0,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        aspectRatio: 2.0,
      ),
      items: aimList().map((card) {
        return Builder(builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.blueAccent,
              child: card,
            ),
          );
        });
      }).toList(),
    );
  }
}
