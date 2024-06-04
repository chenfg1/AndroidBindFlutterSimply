import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

void main() {
  ///这里的CustomFlutterBinding调用务必不可缺少，用于控制Boost状态的resume和pause
  CustomFlutterBinding();
  runApp(MyApp());
}


///创建一个自定义的Binding，继承和with的关系如下，里面什么都不用写
class CustomFlutterBinding extends WidgetsFlutterBinding with BoostFlutterBinding {}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, Route<dynamic> Function(RouteSettings, String)> routerMap = {
    'mainPage': (RouteSettings settings, String uniqueId) {
      Map<String, Object> map = settings.arguments as Map<String, Object> ;
      String data = map['data'] as String;
      return MaterialPageRoute(
        builder: (_) {
          return MainPage(data: data);
        },
      );
    },
    'simplePage': (settings, uniqueId) {
      return CupertinoPageRoute(
          settings: settings,
          builder: (_) {
            Map<String, Object> map = settings.arguments as Map<String, Object>;
            String data = map['data'] as String;
            return SimplePage(
              data: data,
            );
          });
    },
  };

  Route? routeFactory(RouteSettings settings, String uniqueId) {
    FlutterBoostRouteFactory func = routerMap[settings.name] as FlutterBoostRouteFactory;
    return func(settings, uniqueId);
  }

  Widget appBuilder(Widget home) {
    return MaterialApp(
      home: home,
      debugShowCheckedModeBanner: true,

      ///必须加上builder参数，否则showDialog等会出问题
      builder: (_, __) {
        return home;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(
      routeFactory as FlutterBoostRouteFactory,
      appBuilder: appBuilder,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Object? data});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Main Page')),
    );
  }
}

class SimplePage extends StatelessWidget {
  const SimplePage({Object? data});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(child: Text('SimplePage')),
    );
  }
}