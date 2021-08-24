import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sugar_client/service/tag_service.dart';

class RecommendedTag extends StatefulWidget {
  @override
  _RecommendedTagState createState() => _RecommendedTagState();
}

class _RecommendedTagState extends State<RecommendedTag> {

  Future<List<dynamic>> _futureTagList;
  List<dynamic> tagsData;

  @override
  void initState() {
    _futureTagList = loadTagData();
  }

  Future<List<dynamic>> loadTagData() async {
    final totalTag = 6;
    List<dynamic> _tagsData = [];
    _tagsData = await TagService().getRecommendTag();
    if(_tagsData.length < totalTag) {
      _tagsData = _tagsData.sublist(0,_tagsData.length);
    }else {
      _tagsData = _tagsData.sublist(0,totalTag);
    }
    return _tagsData;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0,left: 20.0,top: 20.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "추천태그",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 65.0,
                  child: FutureBuilder(
                      future: _futureTagList, // async work
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          tagsData = snapshot.data;
                          if(tagsData.length > 0){
                            return Container(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(9),
                                itemCount: tagsData.length,
                                itemBuilder: (context, index) {
                                  return tag("# ${tagsData[index]}", "${tagsData[index]}");
                                },
                              )
                            );
                          }else{
                            return Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("추천태그가 아직 없어요 🥺"),
                              )
                            );
                          }
                          
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height / 10 * 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [CircularProgressIndicator()],
                            ),
                          );
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  tag(text, value) {
    return GestureDetector(
      onTap: () {
        Get.toNamed("/search/tag",arguments: value);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.grey[100],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Text(text),
          ),
        ),
      ),
    );
  }


}
