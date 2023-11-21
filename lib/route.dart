import 'package:demo/pages/auth/loginpage.dart';
import 'package:demo/pages/news/newsdetail.dart';
import 'package:demo/pages/news/newsui.dart';
import 'package:flutter/material.dart';

import 'pages/maps/mappage.dart';

class RouteGen{
  static Route<dynamic> generateRoute(RouteSettings settings){

  //  final Object arg = settings.arguments;

    switch (settings.name) {

      case '/': // map sample
        return MaterialPageRoute(builder: (_) =>  loginpage());
      case '/newsui':
        return MaterialPageRoute(builder: (_) => NewsUI());
      case '/newsdetail':
        return MaterialPageRoute(builder: (_) => NewsUI());
      default:
        return _errorRoute(); //if routing error
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}