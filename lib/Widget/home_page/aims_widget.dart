import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/model/constans/constants.dart';
import 'package:havass_coaching_flutter/plugins/provider_services/aims_provider.dart';
import 'package:provider/provider.dart';

class AimsListWidget16 extends StatelessWidget {
  List<Widget> aimList(BuildContext context) {
    AimsProvider _aimsProvider = Provider.of<AimsProvider>(context);
    List<Widget> _widgetlist = List<Widget>();
    int aimsLength = (_aimsProvider.lang == 'en')
        ? Constants.aimsEN16.length
        : Constants.aimsDE16.length;
    for (var i = 0; i < aimsLength; i++) {
      var _widget = Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                color: Colors.grey.withOpacity(0.5))
          ],
          image: DecorationImage(
              image: AssetImage("images/aims_visions_fon.png"),
              fit: BoxFit.fill),
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
                    ? Constants.aimsEN16[i]
                    : Constants.aimsDE16[i],
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
    return CarouselSlider(
      options: CarouselOptions(
        height: 210.0,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        aspectRatio: 2.0,
      ),
      items: aimList(context).map((card) {
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

class AimsListWidget28 extends StatelessWidget {
  List<Widget> aimList(BuildContext context) {
    AimsProvider _aimsProvider = Provider.of<AimsProvider>(context);
    List<Widget> _widgetlist = List<Widget>();
    int aimsLength = (_aimsProvider.lang == 'en')
        ? Constants.aimsEN28.length
        : Constants.aimsDE28.length;
    for (var i = 0; i < aimsLength; i++) {
      var _widget = Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 2,
                color: Colors.grey.withOpacity(0.5))
          ],
          image: DecorationImage(
              image: AssetImage("images/aims_visions_fon.png"),
              fit: BoxFit.fill),
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
                    ? Constants.aimsEN28[i]
                    : Constants.aimsDE28[i],
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
    return CarouselSlider(
      options: CarouselOptions(
        height: 210.0,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        pauseAutoPlayOnTouch: true,
        aspectRatio: 2.0,
      ),
      items: aimList(context).map((card) {
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
