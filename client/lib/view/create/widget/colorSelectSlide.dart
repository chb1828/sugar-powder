import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_client/service/dday_service.dart';
import 'package:sugar_client/view/create/colorProvider.dart';
import 'package:sugar_client/view/create/colorItem.dart';

class ColorSelectSlide extends StatefulWidget {

  @override
  _ColorSelectSlideState createState() => _ColorSelectSlideState();

  final Color update;
  ColorSelectSlide(this.update); 
  
  //더미 데이터 컬러
  final List<ColorItem> colors = [
    ColorItem(Color.fromRGBO(255, 108, 108, 1.0),false),
    ColorItem(Color.fromRGBO(255, 120, 78, 1.0),false),
    ColorItem(Color.fromRGBO(255, 184, 10, 1.0),false),
    ColorItem(Color.fromRGBO(78, 217, 171, 1.0),false),
    ColorItem(Color.fromRGBO(101, 190, 33, 1.0),false),
    ColorItem(Color.fromRGBO(39, 215, 249, 1.0),false),
    ColorItem(Color.fromRGBO(40, 166, 179, 1.0),false),
    ColorItem(Color.fromRGBO(44, 100, 234, 1.0),false),
    ColorItem(Color.fromRGBO(131, 78, 255, 1.0),false),
    ColorItem(Color.fromRGBO(141, 89, 74, 1.0),false),
  ];

}

class _ColorSelectSlideState extends State<ColorSelectSlide> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("색상",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        SizedBox(height: 7),
        Container(
            height: 70.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(8),

              itemCount: widget.colors.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      widget.colors.forEach((element) =>element.isSelected =false);
                      widget.colors[index].isSelected = true;
                      widget.colors.forEach((element) {
                        if(element.isSelected) {
                          Provider.of<ColorProvider>(context,listen : false).setColor(element.color);
                        }
                      });
                    });
                  },
                  child: ColorTile(
                    widget.colors[index],
                  )
                );
              },
            ))
      ],
    );
  }

  @override
  void initState() {
    if(widget.update==null) {
      var rng = new Random();
      int rn = rng.nextInt(widget.colors.length);
      widget.colors[rn].isSelected = true;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<ColorProvider>(context,listen : false).setColor(widget.colors[rn].color);
      });
    }else {
      print(widget.update);
      int index = 0;
      for(var i=0; i<widget.colors.length; i++) {
        if(widget.colors[i].color == ColorItem(widget.update,false).color) {
          index = i;
          break;
        }
      }
      widget.colors[index].isSelected = true;
      WidgetsBinding.instance.addPostFrameCallback((_){
        Provider.of<ColorProvider>(context,listen: false).setColor(widget.update);  // 컬러 설정
      });
    }

  }

}