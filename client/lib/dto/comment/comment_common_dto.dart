class CommentCommonDTO {
  final String comment;
  final int ddayId;
  final String token;

  CommentCommonDTO({this.comment,this.ddayId,this.token});

  factory CommentCommonDTO.fromJson(Map<String, dynamic> json) {
    return CommentCommonDTO(
      comment: json["comment"],
      ddayId: json["ddayId"],
      token: json["token"],
    );
  }
}

