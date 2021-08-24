import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_client/provider/dday_infinite_provider.dart';
import 'package:sugar_client/service/dday_service.dart';

class ListFilter extends StatefulWidget {
  @override
  _ListFilterState createState() => _ListFilterState();
}

class _ListFilterState extends State<ListFilter> {
  String _chosenValue;
  @override
  void initState() {
    super.initState();
    setState(() {
      _chosenValue = "가까운순";
    });
  }

  @override
  Widget build(BuildContext context) {
    var includePastDate =
        Provider.of<DDayInfiniteProvider>(context, listen: false)
            .getIncludePastDate();

    return Container(
      height: MediaQuery.of(context).size.height / 10,
      // color: Colors.red[100],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Text(
                "내 일정",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: DropdownButton(
                    isExpanded: false,
                    iconSize: 30,
                    underline: SizedBox(),
                    value: _chosenValue,
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          "가까운순",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(102, 102, 102, 1.0),
                          ),
                        ),
                        value: "가까운순",
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "생성일순",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(102, 102, 102, 1.0),
                          ),
                        ),
                        value: "생성일순",
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "구독자순",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(102, 102, 102, 1.0),
                          ),
                        ),
                        value: "팔로우순",
                      ),
                      
                      DropdownMenuItem(
                        child: Row(
                          children: [
                            includePastDate == true
                                ? Icon(Icons.check_box, size: 12)
                                : Icon(Icons.check_box_outline_blank, size: 12),
                            Text(
                              "종료 일정 포함",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(102, 102, 102, 1.0),
                              ),
                            )
                          ],
                        ),
                        value: "checkbox",
                      ),
                    ],
                    onChanged: (String value) {
                      setState(() {
                        if (value != "checkbox") {
                          _chosenValue = value;
                          // update current filter value
                          Provider.of<DDayInfiniteProvider>(context,
                                  listen: false)
                              .updateFilterValue(value);
                          Provider.of<DDayInfiniteProvider>(context,
                                  listen: false)
                              .init();
                          Future.microtask(() {
                            Provider.of<DDayInfiniteProvider>(context,
                                    listen: false)
                                .fetchItems(sort: value);
                          });
                        } else {
                          //Set checkbox status
                          Provider.of<DDayInfiniteProvider>(context,
                                  listen: false)
                              .toggleIncludePastDate();
                          //Get currently selected filter value
                          var currentFilterValue =
                              Provider.of<DDayInfiniteProvider>(context,
                                      listen: false)
                                  .getDefaultFilterValue();

                          Provider.of<DDayInfiniteProvider>(context,
                                  listen: false)
                              .init();

                          Future.microtask(() {
                            Provider.of<DDayInfiniteProvider>(context,
                                    listen: false)
                                .fetchItems(sort: currentFilterValue);
                          });
                        }
                      });
                    },
                  ),
                  // child: DropdownButton<String>(
                  //   underline: SizedBox(),
                  //   value: _chosenValue,
                  //   items: <String>[
                  //     '생성일순',
                  //     '팔로우순',
                  //     '가까운순',
                  //   ].map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(
                  //         value,
                  //         style: TextStyle(
                  //           fontSize: 14,
                  //           color: Color.fromRGBO(102, 102, 102, 1.0),
                  //         ),
                  //       ),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String value) {
                  //     setState(() {
                  //       _chosenValue = value;
                  //       // print(_chosenValue);
                  //       Provider.of<DDayInfiniteProvider>(context, listen: false)
                  //           .init();
                  //       Future.microtask(() {
                  //         Provider.of<DDayInfiniteProvider>(context,
                  //                 listen: false)
                  //             .fetchItems(sort: value);
                  //       });
                  //     });
                  //   },
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
