import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sugar_client/view/create/createDDay.dart';
import 'package:sugar_client/view/home/discovery/widget/eachMonthDday.dart';
import 'package:sugar_client/view/home/discovery/widget/recommendedTag.dart';
import 'package:sugar_client/view/home/discovery/widget/searchBar.dart';
import 'package:sugar_client/view/home/discovery/widget/upCommingEvent.dart';
import 'package:sugar_client/view/home/setting/setting.dart';

class DiscoveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: color,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            pinned: true,
            backgroundColor: Colors.white,
            title: SearchBar(),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RecommendedTag(),
                UpCommingEvent(),
                EachDday()
              ],
            ),
          )
        ],
      ),
      endDrawer: Container(
          width: MediaQuery.of(context).size.width-20,
          height: MediaQuery.of(context).size.height,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
            child: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: Setting(),
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCupertinoModalBottomSheet(
              expand: true,
              barrierColor: Color.fromRGBO(178, 178, 178, 60.0),
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => CreateDDay(null));
        },
        child: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
