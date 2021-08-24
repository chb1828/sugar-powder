class CommentDTO {
  int id;
  String comment;
  String nickname;
  String createTime;
  bool owner;
  bool creator;

  CommentDTO(
      {this.id,
      this.comment,
      this.nickname,
      this.createTime,
      this.owner,
      this.creator
      });

  CommentDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    nickname = json['nickname'];
    createTime = json['createTime'];
    owner = json['owner'];
    creator = json['creator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['nickname'] = this.nickname;
    data['createTime'] = this.createTime;
    data['owner'] = this.owner;
    data['creator'] = this.creator;
    return data;
  }
}