import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/dto/dday/dday_list_dto.dart';
import 'package:sugar_client/service/dday_service.dart';
import 'package:sugar_client/view/home/today/widget/listDdayTiles.dart';

class SearchByTag extends StatefulWidget {

  double initialOffset;
    @override
  _SearchByTagState createState() => _SearchByTagState();
}

class _SearchByTagState extends State<SearchByTag> {

  Future<List<DDayListDTO>> _futuerGetDdayList;

  String selectedTagTitle;

  @override
  void initState() {
    super.initState();
    selectedTagTitle = Get.arguments;
    _futuerGetDdayList = DDayPostService().getSearchDdays(selectedTagTitle, 0, 10);
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                centerTitle: false,
                title: appBar(),
              ),
              body: SingleChildScrollView(
                child: FutureBuilder(
                  future: _futuerGetDdayList, // async work
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else if (snapshot.data.length > 0) {
                          print(snapshot.data[0].followerCount);
                          print('============');
                          return SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: [
                                    for (var item in snapshot.data)
                                     
                                      DDayTile(item.id, item.title, item.emoji,
                                          item.date, item.color, item.ddayType, item.followerCount)
                                  ],
                                )
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*(0.8),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "🧐",
                                        style: TextStyle(fontSize: 60),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "검색결과가 없습니다",
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                102, 102, 102, 1),
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                    }
                  },
                ),
              )
            ),
          ],
        ),
      ),
    );
  }


  Widget appBar() {
    return Container(
      child: Transform(
        // you can forcefully translate values left side using Transform
        transform: Matrix4.translationValues(0.0, 0.0, 0.0),
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 6, 5),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 9,
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Image.asset(
                                  "assets/icons/iconBack.png",
                                  width: 24,
                                  height: 24,
                                ),
                              )),
                        ),
                        Expanded(
                          flex: 8,
                          child: Center(
                            child: Container(
                              child: Text(
                                "$selectedTagTitle",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}