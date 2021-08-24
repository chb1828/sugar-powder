class DdayTileObj {
  String title;
  String tagline;
  String icon;
  String dDayDate;
  String dDayIconBg;

  DdayTileObj(
      {this.title, this.tagline, this.icon, this.dDayDate, this.dDayIconBg});

  DdayTileObj.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    tagline = json['tagline'];
    icon = json['icon'];
    dDayDate = json['dDayDate'];
    dDayIconBg = json['dDayIconBg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['tagline'] = this.tagline;
    data['icon'] = this.icon;
    data['dDayDate'] = this.dDayDate;
    data['dDayIconBg'] = this.dDayIconBg;
    return data;
  }
}