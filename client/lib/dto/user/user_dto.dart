class UserDTO {
  int id;
  String nickname;
  String token;
  String deviceToken;
  bool notiYn;

  UserDTO({this.id, this.nickname, this.token, this.deviceToken, this.notiYn});

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
        id: json["id"],
        nickname: json["nickname"],
        token: json["token"],
        deviceToken: json["deviceToken"],
        notiYn: json["notiYn"],
    );
  }

}

