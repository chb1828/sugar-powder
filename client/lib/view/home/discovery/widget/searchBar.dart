import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Get.offAndToNamed("/search");
      },
      child:
         Container(
    
          // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          height: 40,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromRGBO(244, 245, 246, 1),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 10, 8, 10),
                  child: Icon(
                    Icons.search,
                    color: Color.fromRGBO(137, 137, 137, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                  child: Text(
                    "디데이를 검색하세요",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(137, 137, 137, 1),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

    );
  }
}
