import 'package:flutter/material.dart';
import 'package:get/get.dart';

@deprecated
class LicencePage extends StatefulWidget{
  _LicencePageState createState() => _LicencePageState();
}

class _LicencePageState extends State<LicencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: Text("오픈소스 라이센스",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white60,
      ),
      body: Container(
        child: Row(

        ),
      ),
    );
  }

}