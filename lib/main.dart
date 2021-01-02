import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tales/config/constants/theme_constants.dart';
import 'package:tales/config/navigation/router_class.dart';
import 'package:tales/modelview/player_model_view.dart';
import 'package:tales/modelview/tale_model_view.dart';
import 'package:tales/utils/locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setup();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        child: MultiProvider(
            providers: [
          ChangeNotifierProvider<PlayerModelView>(
            create: (_) => PlayerModelView(),
          ),
          ChangeNotifierProvider<TaleModelView>(
            create: (_) => TaleModelView(),
          ),
        ],
            child: MaterialApp(
              title: 'Masallar',
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouterClass.generateRoute,
              theme: ThemeConstants.lightThemeAndroid,
            )));
  }
}
