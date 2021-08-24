import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sugar_client/provider/month_provider.dart';
import 'package:sugar_client/view/home/home.dart';
import 'package:sugar_client/view/home/today/widget/listDdayTiles.dart';

class ResultByMonth extends StatefulWidget {

  @override
  _ResultByMonthState createState() => _ResultByMonthState();
}

class _ResultByMonthState extends State<ResultByMonth> {

  ScrollController _scrollController;
  double changedOffset;
  int _selectedIndex = 0;
  ResultByMonthArguments arguments;

  @override
  void initState() {
    super.initState();
    arguments = Get.arguments;
    Future.microtask(() => {
       Provider.of<MonthProvider>(context, listen: false).fetchItem(month:arguments.month)
    });

    changedOffset = arguments.offset;
    _selectedIndex = int.parse(arguments.month)-1;
    _scrollController = ScrollController(
        initialScrollOffset:
          arguments.offset != null ? arguments.offset : 0.0)
      ..addListener(() {
        changedOffset = _scrollController.offset;
        print("changedoffset = ${_scrollController.offset}");
      });
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<MonthProvider>(context);
    final cache = provider.cache;
    int navigateToDiscoveryPage = 1;

    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Text("월별 디데이",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  elevation: 0,
                  leading: Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: IconButton(
                        icon: IconTheme(
                            data: IconThemeData(color: Colors.black),
                            child:  Image.asset(
                                "assets/icons/iconBack.png",
                                width: 24,
                                height: 24
                            )
                        ),
                        onPressed: () {
                          Get.back();
                          //Get.offAllNamed("/home", arguments: 1);
                        },
                      )
                  ),
                  // title: appBar(),
                ),
              body: Column(
                children: [
                  monthSelect(),
                  SizedBox(height: 18.0,),
                  Expanded(
                    child: FutureBuilder(
                      future: cache, // async work
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Container(
                                height: MediaQuery.of(context).size.height * 0.6,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                )
                            );
                          default:
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            else if (snapshot.hasData && snapshot.data.length > 0) {
                              // print('start----');
                              // print(_dDayList.length);
                              // print('END------');
                              return SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    // monthSelect(width),
                                    Column(
                                      children: [
                                        for (var item in snapshot.data)
                                          DDayTile(
                                              item.id,
                                              item.title,
                                              item.emoji,
                                              item.date,
                                              item.color,
                                              item.ddayType,
                                              item.followerCount)
                                      ],
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                  height: MediaQuery.of(context).size.height * 0.7,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                      ),
                                    ],
                                  )
                              );
                            }
                        }
                      },
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget monthSelect() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      // margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 40.0,
      child: ListView.builder(
        controller: _scrollController,
        // controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (context, index) {
          return Row(
            children: [
              monthTag("${index+1}",_selectedIndex != null && _selectedIndex == index ? true : false)
            ],
          );
        },
      ),
    );
  }

  Widget monthTag(String month,bool activeCheck) {

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 6, 0, 0),
        child: Container(
          decoration: BoxDecoration(
            color: activeCheck ? Colors.black : Color.fromRGBO(243, 247, 247, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          width: 56.0,
          height: 40.0,
          child: Center(
            child: Text(
              "${month}월",
              style: TextStyle(fontSize: 16, color: activeCheck ?Colors.white : Color.fromRGBO(137, 137, 137, 1)),
            ),
          ),
        ),
      ),
      onTap: () {
        // 원재님 눌렀을때 렌더링 해주는 부분입니다.
        setState(() {
          this._selectedIndex = int.parse(month) - 1;     //  달은 인덱스에서 +1 형태로 보여져야 하고 원래 index 는 더한곳에서 -1 해야함
        });
        Provider.of<MonthProvider>(context, listen: false).fetchItem(month:month);
      },
    );

  }

  Widget appBar() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(239, 239, 239, 1.0),
                  width: 1,
              ),
            ),
          ),

      child: Transform(
        // you can forcefully translate values left side using Transform
        transform: Matrix4.translationValues(0.0, 0.0, 0.0),
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 6, 5),
            child: Column(
              children: [
                Row(
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
                                      Get.offAndToNamed("/discovery");
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
                                    "월별 디데이",
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
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                              onTap: () {
                                Get.offAndToNamed("/discovery");
                              },
                              child: Icon(Icons.clear,
                                  color: Colors.black, size: 28)),
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: monthSelect(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultByMonthArguments {

  final String month;
  final double offset;

  ResultByMonthArguments(this.month, this.offset);

}
