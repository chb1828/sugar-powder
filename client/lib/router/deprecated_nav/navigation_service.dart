import 'package:flutter/cupertino.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName,arguments: arguments);
  }

  Future<dynamic> navigateReplaceTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushReplacementNamed(routeName,arguments: arguments);
  }

  Future<dynamic> navigateRemoveUntilTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(routeName,(Route route) => false, arguments:arguments);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }

}