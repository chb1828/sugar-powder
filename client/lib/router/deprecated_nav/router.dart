import 'package:flutter/material.dart';
import 'package:sugar_client/view/dDaySearch/dDaySearch.dart';
import 'package:sugar_client/view/dDaySearch/resultsbyMonth.dart';
import 'package:sugar_client/view/dDaySearch/searchByTag.dart';
import 'package:sugar_client/view/home/discovery/discovery.dart';
import 'package:sugar_client/view/home/setting/page/IntroducePage.dart';
import 'package:sugar_client/view/home/setting/page/licencePage.dart';
import 'package:sugar_client/view/home/setting/page/noticePage.dart';
import 'package:sugar_client/view/home/setting/page/policyPage.dart';
import 'package:sugar_client/view/home/setting/page/setProfilePage.dart';
import 'package:sugar_client/view/home/setting/page/termsPage.dart';
import 'package:sugar_client/view/home/today/detail/detail.dart';
import 'package:sugar_client/view/home/today/today.dart';
import 'package:sugar_client/view/login/index.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch (settings.name) {
      case '/today':
        if(args is String) {
          return MaterialPageRoute(builder: (_) => TodayScreen());
        }
        return _errorRoute();

      case '/discovery':
        return  MaterialPageRoute(builder: (_) => DiscoveryScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => Login());

      case '/detail':
        if(args is int) {
          return MaterialPageRoute(
            builder: (context) => DDayDetail(),
          );
        }
        return _errorRoute();

      case '/searchbytag':
        if(args is String) {
          return MaterialPageRoute(
            builder: (context) => SearchByTag(),
          );
        }
        return _errorRoute();

      case '/search':
        return MaterialPageRoute(builder: (_) => DdaySearchScreen());

      case '/terms':
        return MaterialPageRoute(builder: (_) => TermsPage());

      case '/policy':
        return MaterialPageRoute(builder: (_) => PolicyPage());

      case '/introduce':
        return MaterialPageRoute(builder: (_) => IntroducePage());

      case '/licence':
        return MaterialPageRoute(builder: (_) => LicencePage());

      case '/notice':
        return MaterialPageRoute(builder: (_) => NoticePage());

      case '/profile':
        return MaterialPageRoute(builder: (_) => SetProfilePage());

      case '/profile':
        return MaterialPageRoute(builder: (_) => SetProfilePage());

      case '/month':
        if(args is ResultByMonthArguments) {
          return MaterialPageRoute(
            builder: (context) => ResultByMonth(),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}


