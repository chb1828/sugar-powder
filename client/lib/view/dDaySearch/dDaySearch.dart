import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/dto/dday/dday_list_dto.dart';
import 'package:sugar_client/service/dday_service.dart';
import 'package:sugar_client/util/calculator.dart';
import 'package:sugar_client/view/home/today/widget/listDdayTiles.dart';

class DdaySearchScreen extends StatefulWidget {
  DdaySearchScreen({Key key}) : super(key: key);

  @override
  _DdaySearchScreenState createState() => _DdaySearchScreenState();
}

class _DdaySearchScreenState extends State<DdaySearchScreen> {

  TextEditingController _controller = TextEditingController();

  Timer _debounce;

  ScrollController _scrollController;
  final _ddayBloc= DdayBloc();

  int pageNumber;
  int _currentPage = 0, _limit = 20;
  bool itemCheck = true;
  List<DDayListDTO> loaded = new List();

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _ddayBloc._ddaysController.add(null);
      _currentPage = 0;
      loaded.clear();
      return;
    }
    loaded.clear();
    _ddayBloc._ddaysController.add(null);
    _currentPage = 0;
    if(!await _ddayBloc.fetchDdays(_controller.text,_currentPage,_limit)) {
      setState(() {
        itemCheck = false;
      });
    }
  }

  void _scrollListener() async{
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _currentPage++;
      if(!await _ddayBloc.fetchDdays(_controller.text,_currentPage,_limit)) {
        setState(() {
          itemCheck = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        //  elevation: 0,
        centerTitle: false,
        title: searchBar(),
      ),

      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: _ddayBloc.ddaysStream,
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              
              default:
                if (snapshot.hasError)
                  return noSearchRecordsFound("데이터를 불러올수없습니다", "🤔");
                else if (snapshot.data == null)
                  if( _controller.text == "" ||  _controller.text == null){
                    return noSearchRecordsFound("디데이를 검색하세요", "🔍");
                  }else{
                     return noSearchRecordsFound("검색결과가 없습니다", "🧐");
                  }
                else if (snapshot.data == "waiting")
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else if (snapshot.data.length > 0) {
                  loaded = snapshot.data;
                  return ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: loaded.length,
                    itemBuilder: (context, item) {
                      if (item == loaded.length-1) {
                        return Column(
                          children: [
                            DDayTile(
                                loaded[item].id,
                                loaded[item].title,
                                loaded[item].emoji,
                                loaded[item].date,
                                loaded[item].color,
                                loaded[item].ddayType,
                                loaded[item].followerCount),
                            itemCheck ? Container(
                              height: 70,
                              child: Center(
                                  child:  CircularProgressIndicator()
                              ),
                            ) : Container()
                          ],
                        );
                      }
                      return DDayTile(loaded[item].id,loaded[item].title,
                          loaded[item].emoji, loaded[item].date, loaded[item].color, loaded[item].ddayType, loaded[item].followerCount);
                    },
                  );
                } else {
                  return noSearchRecordsFound("검색결과가 없습니다", "🧐");
                }
            }
          },
        ),
      ),
    );
  }

  Widget noSearchRecordsFound(passedText, emoji) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${emoji}",
                    style: TextStyle(fontSize: 60),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${passedText}",
                    style: TextStyle(
                        color: Color.fromRGBO(102, 102, 102, 1), fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget singleSearchResultData(item) {
    var results = getLeftDdays(item['date']);
    print(results);
    var leftDday = results['leftDday'];
    var parsedDate = results['dDayDate'];
    int parsedBgColor = int.parse("0x" + item['color']);

    return InkWell(
      focusColor: Colors.grey[300],
      highlightColor: Colors.grey[300],
      onTap: () {
        Get.offAndToNamed("/detail/${item['id']}");
      },
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              title: Container(
                child: Row(
                  children: <Widget>[
                    //Dday Title
                    Expanded(
                      flex: 6,
                      child: Text(item['title']),
                    ),
                    //Dday count
                    Expanded(
                      flex: 4,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text("${leftDday}",
                              style: TextStyle(fontSize: 25)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              subtitle: Text(parsedDate),
              leading: Container(
                margin: EdgeInsets.only(left: 6.0),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 70.0,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      //Icon Background Color
                      color: Color(parsedBgColor),
                    ),
                    child: Center(
                      child: Text(
                        //Icon
                        item['emoji'],
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
      child: Transform(
        // you can forcefully translate values left side using Transform
        transform: Matrix4.translationValues(0.0, 0.0, 0.0),
        child: Container(
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(fontSize: 17.0, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: '디데이를 검색하세요',
                        contentPadding: const EdgeInsets.only(
                            left: 20.0, bottom: 10, top: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onChanged: (String text) {
                        if (_debounce?.isActive ?? false) _debounce.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 1000), () {
                          _search();
                        });
                      },
                      controller: _controller,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 12.0),
                      child: GestureDetector(
                          onTap: () {
                            Get.offAndToNamed("/home", arguments: 1);
                          },
                          child: Icon(Icons.clear,
                              color: Colors.black, size: 28)),
                    )
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DdayBloc {
  final _ddays = <DDayListDTO>[];

  final StreamController<List<DDayListDTO>> _ddaysController = StreamController<List<DDayListDTO>>();
  Stream<List<DDayListDTO>> get ddaysStream => _ddaysController.stream;

  Future<bool> fetchDdays(String text,_currentPage,_limit) async {
    var _data = await DDayPostService().getSearchDdays(text, _currentPage, _limit);
    if(_data.isNotEmpty) {
      _ddays.addAll(_data);
      _ddaysController.sink.add(_ddays);
      if(_currentPage==0 && _data.length<_limit) {
        return false;
      }
    }else {
      return false;
    }
    return true;
  }

  void dispose() {
    _ddaysController.close();
    _ddays.clear();
  }
}