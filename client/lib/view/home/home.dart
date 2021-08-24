import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sugar_client/view/create/createDDay.dart';
import 'package:sugar_client/view/home/discovery/discovery.dart';
import 'package:sugar_client/view/home/setting/setting.dart';
import 'package:sugar_client/view/home/today/today.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  int index = 0 ;


  List<Widget> _widgets = [TodayScreen(), DiscoveryScreen()];

  tapped(int tappedIndex) {
    setState(() {
      index = tappedIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var argument = Get.arguments;
    argument != null ? index = argument : index = 0 ;
  }
  
  @override
  Widget build(BuildContext context) {
    
    print(index);
    return Scaffold(
      appBar: topMenu(),
      body: _widgets[index],
      endDrawer: Container(
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0)),
            child: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: Setting(),
            ),
          )),
    );
  }

  topMenu() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: false,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: Builder(
            builder: (context) => IconButton(
              icon: IconTheme(
                data: IconThemeData(color: Colors.black),
                child: Icon(Icons.menu),
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        )
      ],
      title: Transform(
        // you can forcefully translate values left side using Transform
        transform: Matrix4.translationValues(0.0, 0.0, 0.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Row(
              children: [
                InkWell(
                  onTap: () => tapped(0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '오늘',
                      style: TextStyle(
                          color: index == 0 ? Colors.black : Color.fromRGBO(137,137,137, 1.0),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // end today menu
                // start discovery menu
                InkWell(
                  onTap: () => tapped(1),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '발견',
                      style: TextStyle(
                           color: index == 1 ? Colors.black : Color.fromRGBO(137,137,137, 1.0),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
      // backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
}

// class WhichScreenToRenderArgument {
//   final int index;

//   WhichScreenToRenderArgument(this.index);
// }