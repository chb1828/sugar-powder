import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/util/Paragraph.dart';

class PolicyPage extends StatefulWidget {
  _PolicyPageState createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "개인정보 처리방침",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
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
              Text("1. 개인정보의 수집 및 이용목적",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Padding(
                padding: EdgeInsets.only(left: 5, top: 10),
                child: Text(
                    "개인정보는 생존하는 개인에 관한 정보로서 서비스 이용자를 식별할 수 있는 정보(당해 정보만으로는 특정개인을 식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함)를 말합니다. ‘데이데이’이 수집한 개인정보는 ‘데이데이’ 서비스의 기본 기능 제공을 목적으로 활용합니다."),
              ),
              SizedBox(
                height: 20,
              ),
              Text("2. 수집하는 개인정보의 항목 및 수집방법",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Padding(
                  padding: EdgeInsets.only(left: 5, top: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("가. 수집하는 개인정보의 항목"),
                        Text(
                            "‘데이데이’는 회원가입, 상담, 서비스 신청, 서비스 개선 등을 위해 아래와 같은 개인정보를 수집하고 있습니다."),
                        Paragraph([
                          ParagraphItem(text: "카카오 로그인 정보: ID, 비밀번호, 이메일",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "닉네임, 서비스 이용 기록, 접속 로그, 쿠키, 접속 IP 정보",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,)
                        ]),
                        Text("나. 개인정보 수집방법"),
                        Text("다음과 같은 방법으로 개인정보를 수집합니다."),
                        Paragraph([
                          ParagraphItem(text: '홈페이지 회원가입(소셜 로그인 정보를 전달 받음), 피드백 전송, 이벤트 응모, 생성정보 수집 툴을 통한 수집',icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: '서비스 사용 중 이용자의 자발적 제공을 통한 수집',icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                        ]),
                      ])
              ),
              SizedBox(
                height: 20,
              ),
              Text("3. 개인정보의 활용",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Padding(
                  padding: EdgeInsets.only(left: 5, top: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("‘데이데이’는 수집한 개인정보를 다음의 목적을 위해 활용합니다."),
                        Paragraph([
                          ParagraphItem(text: "회원 관리 회원제 서비스 이용에 따른 본인확인, 개인 식별, 불량회원의 부정 이용 방지와 비인가 사용 방지, 가입 의사 확인, 불만처리 등 민원처리, 고지사항 전달",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "마케팅 및 광고에 활용, 신규 서비스(제품) 개발 및 특화, 이벤트 등 광고성 정보 전달, 인구통계학적 특성에 따른 서비스 제공 및 광고 게재, 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,)
                        ]),
                        Text("나. 개인정보 수집방법"),
                        Text("다음과 같은 방법으로 개인정보를 수집합니다."),
                        Paragraph([
                          ParagraphItem(text: '홈페이지 회원가입(소셜 로그인 정보를 전달 받음), 피드백 전송, 이벤트 응모, 생성정보 수집 툴을 통한 수집',icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: '서비스 사용 중 이용자의 자발적 제공을 통한 수집',icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                        ]),
                      ])
              ),
              SizedBox(
                height: 20,
              ),
              Text("4. 개인정보의 보유 및 이용기간",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Padding(
                  padding: EdgeInsets.only(left: 5, top: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다."),
                        Paragraph([
                          ParagraphItem(text: "이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "표시/광고에 관한 기록보존 이유 : 전자상거래등에서의 소비자보호에 관한 법률보존 기간 : 6개월",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "계약 또는 청약철회 등에 관한 기록보존 이유 : 전자상거래등에서의 소비자보호에 관한 법률보존 기간 : 5년",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "소비자의 불만 또는 분쟁처리에 관한 기록보존 이유 : 전자상거래등에서의 소비자보호에 관한 법률보존 기간 : 3년",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "방문에 관한 기록",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,)
                        ]),
                        Text("보존 이유 : 통신비밀보호법"),
                        Text("보존 기간 : 3개월"),
                      ])
              ),
              SizedBox(
                height: 20,
              ),
              Text("5. 개인정보의 파기절차 및 방법",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Padding(
                  padding: EdgeInsets.only(left: 5, top: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다. 개인정보 파기절차 및 방법은 다음과 같습니다."),
                        Text("가. 파기절차"),
                        Paragraph([
                          ParagraphItem(text: "이용자가 회원가입 등을 위해 입력한 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조)일정 기간 저장된 후 파기됩니다.",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "동 개인정보는 법률에 의한 경우가 아니고서는 보유되는 이외의 다른 목적으로 이용되지 않습니다.",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                        ]),
                        Text("나. 파기방법"),
                        Paragraph([
                          ParagraphItem(text: "종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "전자적 파일 형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                        ]),
                      ])
              ),
              SizedBox(
                height: 20,
              ),
              Text("개인정보관리책임자 및 담당자의 연락처",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Padding(
                  padding: EdgeInsets.only(left: 5, top: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("‘데이데이’ 서비스를 이용하며 발생하는 모든 개인정보보호 관련 민원을 개인정보관리책임자 혹은 담당부서로 신고하실 수 있습니다. ‘데이데이’는 이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다."),
                        Paragraph([
                          ParagraphItem(text: "이름 : ",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "연락처 : ",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                        ]),
                        Text("기타 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다."),
                        Paragraph([
                          ParagraphItem(text: "개인정보침해신고센터 \n(www.118.or.kr / 118)",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "정보보호마크인증위원회 \n(www.eprivacy.or.kr / 02-580-0533~4)",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "대검찰청 첨단범죄수사과 \n(http://www.spo.go.kr / 02-3480-2000)",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                          ParagraphItem(text: "경찰청 사이버테러대응센터 \n(www.ctrc.go.kr / 02-392-0330)",icon: Icon(Icons.brightness_1,size: 7),fontSize: 14,space: 5.0,),
                        ]),
                      ])
              ),
              SizedBox(
                height: 20,
              ),
              Text("7. 고지의 의무",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Padding(
                  padding: EdgeInsets.only(left: 5, top: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("현 개인정보취급방침의 내용 추가, 삭제 및 수정이 있을 시에는 시행일자 최소 7일전부터 서비스 내 공지사항을 통해 공고할 것입니다."),
                        Text("[시행일] 본 개인정보처리방침은 2020년 12월 1일부터 적용됩니다."),
                      ])
              ),
            ]),
          ),
        ));
  }
}