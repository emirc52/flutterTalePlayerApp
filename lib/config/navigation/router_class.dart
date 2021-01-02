import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tales/config/constants/route_constants.dart';
import 'package:tales/view/main_page.dart';
import 'package:tales/view/player/player_page.dart';

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteConstant.mainRoute:
        return CupertinoPageRoute(builder: (_) => MainPage());
      case RouteConstant.playerPageRoute:
        return CupertinoPageRoute(builder: (_) => PlayerPage(arguments));
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text("Hata"),
              centerTitle: true,
            ),
            body: Center(
              child: Text('Ters giden bir şeyler oldu'),
            ),
          ),
        );
    }
  }
}
