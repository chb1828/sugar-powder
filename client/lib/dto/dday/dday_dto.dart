class DDayDTO {
  int id;
  String title;
  String emoji;
  String color;
  String date;
  String time;
  String ddayType;
  String place;
  List tags;
  String token;
  String description;


  DDayDTO({this.title, this.emoji, this.color, this.date, this.time,this.ddayType, this.place,
      this.tags, this.token, this.description, this.id});

  factory DDayDTO.fromJson(Map<String, dynamic> json) {
    return DDayDTO(
        id: json["id"],
        title: json["title"],
        emoji: json["emoji"],
        color: json["color"],
        date: json["date"],
        ddayType: json["ddayType"],
        place: json["place"],
        tags: json["tags"],
        token: json["token"],
        description: json["description"]
    );
  }
}

