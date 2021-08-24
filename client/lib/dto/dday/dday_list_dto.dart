import 'package:sugar_client/util/calculator.dart';

class DDayListDTO {
  int id;
  String title;
  String emoji;
  String date;
  String dateTime;
  String place;
  String color;
  String description;
  List<String> tags;
  bool owner;
  String ddayType;
  int followerCount;
  String ownerNickname;
  bool noti;

  DDayListDTO(
      {this.id,
        this.title,
        this.emoji,
        this.date,
        this.place,
        this.color,
        this.description,
        this.tags,
        this.owner,
        this.ddayType,
        this.followerCount,
        this.ownerNickname,
        this.noti});

  DDayListDTO.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    title = json['title'];
    emoji = json['emoji'];
    date = json['date'];
    dateTime = getDetailDateTimeFormat(json['date']);
    place = json['place'];
    color = json['color'];
    description = json['description'];
    if(json['tags'] != null){
      tags = json['tags'].cast<String>();
    }

    owner = json['owner'];
    ddayType = json['ddayType'];
    followerCount = json['followerCount'];
    ownerNickname = json['ownerNickname'];
    noti = json['noti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['emoji'] = this.emoji;
    data['date'] = this.date;
    data['place'] = this.place;
    data['color'] = this.color;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['owner'] = this.owner;
    data['ddayType'] = this.ddayType;
    data['followerCount'] = this.followerCount;
    data['ownerNickname'] = this.ownerNickname;
    data['noti'] = this.noti;
    return data;
  }

}