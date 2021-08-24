import 'package:get/get.dart';
import 'package:sugar_client/view/dDaySearch/dDaySearch.dart';
import 'package:sugar_client/view/dDaySearch/resultsbyMonth.dart';
import 'package:sugar_client/view/dDaySearch/searchByTag.dart';
import 'package:sugar_client/view/home/discovery/discovery.dart';
import 'package:sugar_client/view/home/setting/page/IntroducePage.dart';
import 'package:sugar_client/view/home/setting/page/licencePage.dart';
import 'package:sugar_client/view/home/setting/page/noticePage.dart';
import 'package:sugar_client/view/home/setting/page/policyPage.dart';
import 'package:sugar_client/view/home/setting/page/termsPage.dart';
import 'package:sugar_client/view/home/setting/setting.dart';
import 'package:sugar_client/view/home/today/detail/detail.dart';
import 'package:sugar_client/view/home/today/today.dart';
import 'package:sugar_client/view/login/index.dart';
import 'package:sugar_client/view/home/home.dart';
part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.TODAY;

  static final routes = [
    
    GetPage(
      name: Routes.LOGIN,
      page: () => Login(),
    ),
    GetPage(
        name: Routes.TODAY,
        page: () => TodayScreen(),
    ),
    GetPage(
      name: Routes.DISCOVERY,
      page: () => DiscoveryScreen(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => DDayDetail(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => DdaySearchScreen(),
      children: [
        GetPage(
            name: Routes.TAG,
            page: () => SearchByTag()
        ),
        GetPage(
            name: Routes.MONTH,
            page: () => ResultByMonth()
        ),
      ]
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => Setting(),
      children: [
        GetPage(
            name: Routes.TERMS,
            page: () => TermsPage(),
        ),
        GetPage(
            name: Routes.POLICY,
            page: () => PolicyPage()
        ),
        GetPage(
            name: Routes.NOTICE,
            page: () => NoticePage()
        ),
        GetPage(
            name: Routes.LICENCE,
            page: () => LicencePage()
        ),
        GetPage(
            name: Routes.INTRODUCE,
            page: () => IntroducePage()
        ),
        
      ]
    ),
    GetPage(
          name: Routes.HOME,
          page: () => HomeScreen(),
        )
  ];
}