import 'package:flutter/material.dart';

// import 'models/route_argument.dart';
import 'screens.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      // case '/WebView':
      //   return MaterialPageRoute(builder: (_) => WebViewWidget(routeArgument: args as RouteArgument));
      // case '/Pages':
      //   return MaterialPageRoute(builder: (_) => PagesWidget());
      
      
      // case '/Exercise':
      //   return MaterialPageRoute(builder: (_) => ExerciseWidget(routeArgument: args as RouteArgument));
      // case '/Finish':
      //   return MaterialPageRoute(builder: (_) => FinishWidget(routeArgument: args as RouteArgument));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
