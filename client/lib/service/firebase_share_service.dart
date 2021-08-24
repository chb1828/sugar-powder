import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareService {
  Future<Uri> getDynamicLink(obj) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://sugarclient.page.link',
        link:
            Uri.parse('https://sugarclient.page.link/join_dday?dday=${obj.id}'),
        socialMetaTagParameters: SocialMetaTagParameters(
          // title: obj.title,
          // description: "여기를 눌러 링크를 확인하세요.",
           title: "[데이데이] 같이 기억해요!",
          description: "이 디데이 어때요? 데이데이 앱에서 확인해 보세요.",
          imageUrl: Uri.parse(
              "https://res.cloudinary.com/dgchymgve/image/upload/v1617600913/kakaotalkshare_cnqnoh.png"),
        ),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
            shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short),
        androidParameters: AndroidParameters(
          packageName: 'com.sugarpowder.dayday',
          minimumVersion: 1,
        ),
        iosParameters: IosParameters(
            bundleId: 'com.sugarpowder.dayday', minimumVersion: "1"));

    ShortDynamicLink dynamicUrl = await parameters.buildShortLink();
    return dynamicUrl.shortUrl;
  }

  Future<void> initDynamicLinks(BuildContext context) async {
    try {
      FirebaseDynamicLinks.instance.onLink(// 앱이 켜져있을 때에는 이 함수 호출
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
        final Uri deepLink = dynamicLink?.link;
        if (deepLink != null) {
          print(deepLink);
          print(deepLink.queryParameters['dday']);
          final int id = int.parse(deepLink.queryParameters['dday'].toString());
          try {
            //두번 푸시하는데 비효율적
            // Get.offAllNamed("/today",arguments: "CREATE");
            Get.offAllNamed("/home");
            Get.toNamed("/detail/$id");
          } catch (e) {
            print(e.toString());
          }
        }
      }, onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      });

      final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance
          .getInitialLink(); // 앱이 꺼져있을 때에는 이 함수 호출
      final Uri deepLink = data?.link;
      if (deepLink != null) {
        final int id = int.parse(deepLink.queryParameters['dday']
            .toString()); //예외가 발생하기 때문에 이런식으로 컨버팅 해줘야함... 더 좋은 방법 강구
        Get.toNamed("/detail/$id");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
