import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/util/paragraph.dart';

class TermsPage extends StatefulWidget{
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back()
        ),
        title: Text("서비스 이용 약관",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white60,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("'데이데이' 서비스 이용약관",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            SizedBox(height: 20,),
            Text("제 1조(목적)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 10),
              child: Text(
                  "이 이용약관은 '슈가파우더('이하 단체')가 모바일 앱을 통하여 제공하는 서비스와 관련하여 단체와 회원간의 권리와 의무, 책임사항 및 회원의 서비스 이용절차에 관한 사항을 규정함을 목적으로 합니다. 단체는 시스템에 관한 제반 기술과 운영에 대한 모든 권한을 갖고 있습니다."),
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 2조(용어의 정의)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. '서비스'라 함은 구현되는 단말기(PC, TV, 휴대형 단말기 등의 각종 유무선 장치를 포함)와 상관없이 회원이 이용할 수 있는 '데이데이'서비스 및 관련 제반 서비스를 의미합니다."),
                      SizedBox(height: 10,),
                      Text(
                          "2. '이용자'라 함은 데이데이 서비스에 접속한 모든 회원및 비회원을 의미합니다."),
                      SizedBox(height: 10,),
                      Text(
                          "3. '회원'이라 함은 데이데이 서비스에 접속하여 이 약관에 따라 이용계약을 체결하고 데이데이 서비스를 이용하는 이용자를 말합니다."),
                      SizedBox(height: 10,),
                      Text(
                          "4. '닉네임'이라 함은 회원의 식별과 서비스 이용을 위하여 회원이 정하고 단체가 승인하는 문자와 숫자의 조합을 의미합니다."),
                    ])
            ),
            SizedBox(height: 20,),
            Text("제 3조(약관의 정의)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 단체는 이 약관을 서비스를 이용하고자 하는 자와 회원이 알 수 있도록 서비스 화면에 게시합니다."),
                      SizedBox(height: 10,),
                      Text(
                          "2. 단체는 본 약관을 관련 법령을 위배하지 않는 범위에서 수시로 개정할 수 있습니다. 개정된 약관은 온라인에 명시됨으로써 효력을 발생하며 제 1항과 같은 방식으로 공시합니다."),
                      SizedBox(height: 10,),
                      Text(
                          "3. 본 약관에 동의하는 것은 정기적으로 서비스를 방문하여 본 약관의 변경사항을 확인하는 것에 동의함을 의미합니다. 변경된 약관에 대한 정보를 알지 못해 발생하는 이용자의 피해는 단체에서 책임지지 않습니다."),
                      SizedBox(height: 10,),
                      Text(
                          "4. 단체는 이 약관을 개정하는 경우에 개정된 약관의 적용일자를 명시하여 그 적용일자 최소 1주일 이전부터 제 1항의 방법으로 공지합니다."),
                      SizedBox(height: 10,),
                      Text(
                          "5. 회원이 개정된 약관에 동의하지 않는 경우 회원은 탈퇴(해지)를 할 수 있으며, 변경된 약관의 효력 발생일로부터 1주일 이후에도 거부의사를 표시하지 아니하고 서비스를 계속 이용할 경우 개정된 약관에 동의한 것으로 간주합니다."),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 4조(약관 외 준칙)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("본 약관에 명시되지 않는 사항은 전기통신기본법, 전기통신사업법 및 기타 관련 법령의 규정에 준합니다."),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 5조 (이용계약의 체결)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 이용계약은 회원이 되고자 하는 자(이하 \"가입신청자\")가 약관의 내용에 대하여 동의를 한 다음 회원가입 신청을 하고 단체가 이러한 신청에 대하여 승낙함으로써 체결됩니다."),
                      SizedBox(height: 10,),
                      Text("2. 회원이 입력한 정보는 사실로 간주합니다. 내용이 사실과 다를 경우(차명, 비실명, 허위정보 등)와 타인의 정보를 도용한 사실이 명백하게 확인 되는 경우, 단체는 회원에게 회원의 권한을 삭제하며 서비스의 전면적인 이용을 거부 할 수 있고, 이로 인해 발생하는 모든 불이익은 단체가 책임지지 않습니다. 또한 단체는 이를 위하여 필요한 경우에는 재증명을 요구할 수 있습니다."),
                      SizedBox(height: 10,),
                      Text("3. 단체는 회원의 등급에 따라 차별을 둘 수 있으며, 회원은 그 등급에 따라 서비스 이용에 제약을 받을 수 있습니다."),
                      SizedBox(height: 10,),
                      Text("4. 단체는 제 1항목과 같은 방법으로 회원 가입을 신청한 회원이 아래 각 호에 해당하는 조건을 충족 하지 못할 경우 회원가입 승낙을 유보 또는 거부 할 수있습니다."),
                      SizedBox(height: 10,),
                      Text("(1) 등록내용 허위게재 사실이 있는 경우"),
                      SizedBox(height: 10,),
                      Text("(2) 제 3자의 전자우편 주소를 이용하여 신청한 경우"),
                      SizedBox(height: 10,),
                      Text("(3) 약관 및 서비스 이용에 관한 관계법령을 위반하여 회원자격을 상실 된 자"),
                      SizedBox(height: 10,),
                      Text("(4) 사회적 질서 및 미풍양속에 문란이 되는 행위자"),
                      SizedBox(height: 10,),
                      Text("(5) 기타 가입결격 사유에 해당한 자"),
                      SizedBox(height: 10,),
                      Text("5. 회원가입 계약 성립 시점은, 가입 승낙이 가입 신청자에게 도달한 시점을 기준으로 합니다."),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 6조 (개인정보보호 의무)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("단체는 \"정보통신망법\" 등 관계 법령이 정하는 바에 따라 회원의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련법 및 단체의 개인정보취급방침이 적용됩니다. 다만, 단체의 공식 사이트 이외의 링크된 사이트에서는 단체의 개인정보취급방침이 적용되지 않습니다."),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 7조 (회원에 대한 통지)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 단체가 회원에 대한 통지를 하는 경우 서비스 내 전자우편주소 등으로 할 수 있습니다."),
                      SizedBox(height: 10,),
                      Text("2. 단체의 회원 전체에 대한 통지의 경우 홈페이지에 게시함으로써 제1항의 통지에 갈음할 수 있습니다."),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 8조 (단체의 의무)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 단체는 관련법과 이 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적이고 안정적으로 서비스를 제공하기 위하여 최선을 다하여 노력합니다."),
                      SizedBox(height: 10,),
                      Text("2. 단체는 회원이 안전하게 서비스를 이용할 수 있도록 개인정보(신용정보 포함)보호를 위해 보안시스템을 갖추어야 하며 개인정보취급방침을 공시하고 준수합니다."),
                      SizedBox(height: 10,),
                      Text("3. 단체는 서비스 이용과 관련하여 회원으로부터 제기된 의견이나 불만이 정당하다고 인정할 경우에는 이를 처리하여야 합니다. 회원이 제기한 의견이나 불만사항에 대해서는 게시판을 활용하거나 전자우편 등을 통하여 회원에게 처리과정 및 결과를 전달합니다."),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 9조 (회원의 의무)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 회원은 단체의 사전 승낙 없이 서비스를 이용하여 영업활동을 할 수 없으며, 해당 영업활동의 결과에 대해 단체는 책임을 지지 않습니다. 또한 회원은 이와 같은 영업활동으로 단체가 손해를 입은 경우, 회원은 단체에 대해 손해배상의무를 지며, 단체는 해당 회원에 대해 서비스 이용제한 및 적법한 절차를 거쳐 손해배상 등을 청구할 수 있습니다."),
                      SizedBox(height: 10,),
                      Text("2. 회원은 단체의 명시적 동의가 없는 한 서비스의 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여할 수 없으며 이를 담보로 제공할 수 없습니다."),
                      SizedBox(height: 10,),
                      Text("3. 회원은 단체 및 제 3자의 지적 재산권을 침해해서는 안됩니다. 해당 지적 재산권 침해의 결과에 대해 단체는 책임을 지지 않습니다."),
                      SizedBox(height: 10,),
                      Text("4. 회원은 다음 각 호에 해당하는 행위를 하여서는 안되며, 해당 행위를 하는 경우에 단체는 회원의 서비스 이용제한 및 적법 조치를 포함한 제재를 가할 수 있습니다."),
                      SizedBox(height: 10,),
                      Text("(1) 신청 또는 변경 시 허위내용의 등록"),
                      SizedBox(height: 10,),
                      Text("(2) 타인의 정보도용"),
                      SizedBox(height: 10,),
                      Text("(3) 단체가 게시한 정보의 변경"),
                      SizedBox(height: 10,),
                      Text("(4) 단체가 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시"),
                      SizedBox(height: 10,),
                      Text("(5) 단체와 기타 제3자의 저작권 등 지적재산권에 대한 침해"),
                      SizedBox(height: 10,),
                      Text("(6) 단체 및 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위"),
                      SizedBox(height: 10,),
                      Text("(7) 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 서비스에 공개 또는 게시하는 행위"),
                      SizedBox(height: 10,),
                      Text("(8) 다른 이용자를 희롱 또는 위협하거나, 특정 이용자에게 지속적으로 고통 또는 불편을 주는 행위"),
                      SizedBox(height: 10,),
                      Text("(9) 단체의 승인을 받지 않고 다른 사용자의 개인정보를 수집 또는 저장하는 행위"),
                      SizedBox(height: 10,),
                      Text("(10) 기타 불법적이거나 부당한 행위"),
                      SizedBox(height: 10,),
                      Text("5. 회원들간 행위의 책임은 회원들에게 귀속됩니다. 단체에서는 신고된 회원의 행위가 추후 다른 회원에게 추가적인 피해를 입힐 수 있다고 판단되는 경우, 문제 회원을 탈퇴 혹은 아이디 영구 삭제, 등의 후속 조치를 취할 것입니다."),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 10조 ('서비스'의 제공 등)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 단체는 회원에게 아래와 같은 서비스를 제공합니다."),
                      SizedBox(height: 10,),
                      Text("(1) 데이데이 서비스"),
                      SizedBox(height: 10,),
                      Text("(2) 기타 단체가 자체 개발하거나 타 회사와의 협력계약을 통해 회원들에게 제공할 일체의 서비스"),
                      SizedBox(height: 10,),
                      Text("2. 단체에서는 양질의 서비스 제공을 위해 회원들의 프로필 및 컨텐츠의 수정, 보안, 중지 등을 요청할 수 있으며 단체 내부 규정에 따라 일부 서비스 이용을 제한 할 수 있습니다."),
                      SizedBox(height: 10,),
                      Text("3. 단체는 서비스의 일부 또는 전부를 단체의 정책 및 운영의 필요상 수정, 중단, 변경할 수 있으며, 회원에게 별도의 고지 및 보상을 하지 않습니다."),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 11조 (정보의 제공 및 광고의 게재)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 회원이 서비스 내에 작성한 텍스트, 이미지, 링크 등의 기타 정보(이하 \"게시물\")에 대한 책임 및 권리는 게시물을 등록한 회원에게 있습니다."),
                      SizedBox(height: 10,),
                      Text("2. 단체는 회원이 작성한 컨텐츠에 대해서 감시 및 관리할 수 없으며 이에 대해서 책임지지 않습니다. 단체는 회원이 등록하는 게시물의 신뢰성, 진실성, 정확성 등에 대해서 책임지지 않으며 보증하지 않습니다."),
                      SizedBox(height: 10,),
                      Text("3. 서비스에 대한 저작권 및 지적재산권, 단체가 작성한 게시물의 저작권은 단체에 귀속됩니다. 단, 회원이 단독 또는 공동으로 작성한 게시물 및 제휴계약에 따라 제공된 저작물 등은 제외합니다."),
                      SizedBox(height: 10,),
                      Text("4. 회원은 자신이 서비스 내에 게시한 게시물을 단체가 국내ㆍ외에서 다음 목적으로 사용하는 것을 허락합니다."),
                      SizedBox(height: 10,),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 12조 (‘게시물’의 권리와 책임)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 단체는 서비스의 운영과 관련하여 서비스 화면, 홈페이지, 전자우편 등에 광고를 게재할 수 있습니다. 회원은 서비스 이용시 노출 되는 광고 게재에 대해 동의합니다."),
                      SizedBox(height: 10,),
                      Text("2. 단체는 회원이 서비스 이용 중 필요하다고 인정되는 다양한 정보를 공지사항이나 전자우편, 문자 SMS 발송 등의 방법으로 회원에게 제공할 수 있습니다."),
                      SizedBox(height: 10,),
                      Text("3. 광고가 게재된 전자우편을 수신한 회원은 수신거절을 단체에게 할 수 있습니다."),
                      SizedBox(height: 10,),
                      Text("4. 이용자는 단체가 제공하는 서비스와 관련하여 게시물 또는 기타 정보를 변경, 수정, 제한하는 등의 조치를 취하지 않습니다."),
                      SizedBox(height: 10,),
                      Paragraph([
                        ParagraphItem(text: '서비스(제3자가 운영하는 사이트 또는 미디어의 일정 영역 내에 입점하여 서비스가 제공되는 경우를 포함합니다)내에서 게시물을 사용하기 위하여 게시물의 크기를 변환하거나 단순화하는 등의 방식으로 수정하는 것',icon: Icon(Icons.remove,size: 7,),fontSize: 14,space: 5.0,),
                        ParagraphItem(text: '단체에서 운영하는 다른 사이트 또는 다른 회사가 운영하는 사이트에 게시물을 복제ㆍ전송ㆍ전시하는 것',icon: Icon(Icons.remove,size: 7),fontSize: 14,space: 5.0,),
                        ParagraphItem(text: '단체의 서비스를 홍보하기 위한 목적으로 미디어, 통신사 등에게 게시물의 내용을 보도, 방영하게 하는 것. 단, 이 경우 단체는 회원의 개별 동의없이 미디어, 통신사 등에게 게시물 또는 회원정보를 제공하지 않습니다.',icon: Icon(Icons.remove,size: 7),fontSize: 14,space: 5.0,),
                      ]),
                      SizedBox(height: 10,),
                      Text("5. 회원이 회원탈퇴를 한 경우에는 본인 도메인에 기록된 저작물 일체는 삭제됩니다. 단, 저작물이 공동 저작을 통해 작성된 경우에는 공동 저작자의 도메인에 해당 게시물이 남을 수 있고, 제3자에 의하여 보관되거나 무단복제 등을 통하여 복제됨으로써 해당 저작물이 삭제되지 않고 재 게시된 경우에 대하여 단체는 책임을 지지 않습니다. 또한, 본 약관 및 관계 법령을 위반한 회원의 경우 다른 회원을 보호하고, 법원, 수사기관 또는 관련 기관의 요청에 따른 증거자료로 활용하기 위해 회원탈퇴 후에도 관계 법령이 허용하는 한도에서 회원의 아이디 및 회원정보를 보관할 수 있습니다."),
                      SizedBox(height: 10,),
                      Text("6. 회원의 게시물 또는 저작물이 단체 또는 제3자의 저작권 등 지적재산권을 침해함으로써 발생하는 민∙형사상의 책임은 전적으로 회원이 부담하여야 합니다."),
                      SizedBox(height: 10,),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 13조 (계약해제, 해지 등)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 회원은 언제든지 정보 관리 메뉴 등을 통하여 이용계약 해지 신청을 할 수 있으며, 단체는 관련법 등이 정하는 바에 따라 이를 즉시 처리하여야 합니다."),
                      SizedBox(height: 10,),
                      Text("2. 회원이 계약을 해지할 경우, 본 이용약관, 관련법 및 개인정보취급방침에 따라 단체가 회원정보를 보유하는 경우를 제외하고는 해지 즉시 회원의 모든 데이터는 소멸됩니다."),
                      SizedBox(height: 10,),
                      Text("3. 회원의 의무를 성실하게 이행하지 않거나, 약관에서 정한 회원의 의무 및 이용정책에 위반되는 해당하는 행위를 한 회원은 사전 동의 없이 강제 탈퇴 처리할 수 있습니다."),
                      SizedBox(height: 10,),
                      Text("4. 기타 회원의 여건상 지속적인 계약을 이행하지 못한다고 판단될 경우 임의탈퇴 처리할 수 있습니다."),
                      SizedBox(height: 10,),
                      Text("(예: 사망 또는 행방불명, 3개월 이상 활동을 하지 않는 휴면계정 회원 등)"),
                      SizedBox(height: 10,),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 14조 (면책조항)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 단체는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다."),
                      SizedBox(height: 10,),
                      Text("2. 단체는 회원의 귀책사유로 인한 서비스 이용 장애에 대한 책임을 면제합니다."),
                      SizedBox(height: 10,),
                      Text("3. 단체는 회원이 서비스와 관련하여 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을 지지 않습니다."),
                      SizedBox(height: 10,),
                      Text("4. 단체는 회원이 서비스를 이용하여 기대하는 수익을 얻지 못하거나 상실한 것에 대하여 책임을 지지 않습니다."),
                      SizedBox(height: 10,),
                      Text("5. 단체는 회원 신원을 보증하지 않습니다. 또한 회원이 서비스를 이용하며 타 회원으로 인해 입게 되는 정신적 피해에 대하여 보상할 책임을 지지 않습니다."),
                      SizedBox(height: 10,),
                      Text("6. 단체는 이용자 상호간 및 이용자와 제 3자 상호 간에 서비스를 매개로 발생한 분쟁에 대해 개입할 의무가 없으며, 이로 인한 손해를 배상할 책임도 없습니다."),
                      SizedBox(height: 10,),
                      Text("7. 단체의 게시물에 회원이 게재한 글의 저작권은 회원 본인에게 있으며, 이 정보의 진실성 및 저작권에 위배되어 민 형사 상의 문제가 발생 시 책임은 회원 본인에게 있습니다."),
                      SizedBox(height: 10,),
                      Text("8. 단체의 사이트에 게재된 제3의 사이트 주소에 관하여 단체는 어떠한 통제권도 없으며 이로 인하여 발생 하는 손해는 회원 본인에게 있습니다."),
                      SizedBox(height: 10,),
                      Text("9. 단체에서 회원에게 무료로 제공하는 서비스의 이용과 관련해서는 어떠한 손해도 책임을 지지 않습니다."),
                      SizedBox(height: 10,),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 15조 (분쟁의 해결)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 단체와 회원은 서비스와 관련하여 발생한 분쟁을 원만하게 해결하기 위하여 필요한 노력을 합니다."),
                      SizedBox(height: 10,),
                      Text("2. 단체는 회원으로부터 제출되는 불만사항 및 의견을 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 회원께 그 사유와 처리 일정을 즉시 통보해 드립니다."),
                      SizedBox(height: 10,),
                    ])
            ),
            SizedBox(
              height: 20,
            ),
            Text("제 16조 (재판권 및 준거법)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. 이 약관에 명시되지 않은 사항은 전기통신사업법 등 관계법령과 상관습에 따릅니다."),
                      SizedBox(height: 10,),
                      Text("2. 단체의 기타 유료 서비스 이용 회원의 경우, 단체가 별도로 정한 정책에 따릅니다."),
                      SizedBox(height: 10,),
                      Text("3. 서비스 이용으로 발생한 분쟁에 대해 소송이 제기되는 경우 단체의 소재지를 관할하는 법원을 관할 법원으로 합니다."),
                      SizedBox(height: 20,),
                      Text("[시행일] 본 개인정보처리방침은 2020년 12월 1일부터 적용됩니다."),
                    ])
            ),
          ]),
        ),
      )
    );
  }

}