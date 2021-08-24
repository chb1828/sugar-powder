import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_client/view/create/colorProvider.dart';
import 'package:sugar_client/view/create/createDDay.dart';

class ImageProfile extends StatefulWidget {

  TextEditingController _emojiController;
  ImageProfile(this._emojiController);
  @override
  _ImageProfileState createState() => _ImageProfileState();

}

class _ImageProfileState extends State<ImageProfile> {

  String emojiIcon;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: ((builder) => profileBottomSheet()));
            },
            child: getProfileContainer(widget._emojiController.text)));
  }


  Widget profileBottomSheet() {
    return Container(
        height: 233,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            EmojiPicker(
              rows: 3,
              columns: 7,
              buttonMode: ButtonMode.MATERIAL,
              recommendKeywords: ["racing", "horse"],
              numRecommended: 10,
              onEmojiSelected: (emoji, category) {
                setState(() {
                  emojiIcon = emoji.emoji;
                  widget._emojiController.text = emojiIcon;
                });
              },
            )
          ],
        ));
  }

  Widget getProfileContainer(String emoji) {
    if(emoji.isEmpty) {
      return getProfileNone();
    }else {
      return getProfileEmoji(emoji);
    }
  }

  Widget getProfileNone() {
    return Stack(
      children: [
        SizedBox(
          width: 120.0,
          height: 80.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0,),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(245, 245, 245, 1),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0),
                  ],
                  image: new DecorationImage(
                      scale: 2.0,
                      image: AssetImage('assets/empty-profile.png'),
                      fit: BoxFit.none),
                ),
              ),
            ),
          )
        ),
        Positioned(
            bottom: 1,
            right: 10,
            child: Container(
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.black,
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: Icon(Icons.create,size: 18,),
                ),
              ),
            ))
      ],
    );
  }

  Widget getProfileEmoji(String emoji) {
    return Stack(
      children: [
        SizedBox(
          width: 80.0,
          height: 80.0,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(28.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Provider.of<ColorProvider>(context).getColor(),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0),
                  ],
                ),
                child: Center(
                  child: Text(
                      emoji,
                      style: TextStyle(fontSize: 40)),
                )
              )),
        ),
        Positioned(
            bottom: 1,
            right: 1,
            child: Container(
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black,
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: Icon(Icons.edit,size: 13.0,),
                ),
              ),
            ))
      ],
    );
  }
}