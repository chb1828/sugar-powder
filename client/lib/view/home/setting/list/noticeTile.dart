import 'package:flutter/material.dart';

class Notice {
  String emoji;
  String notice;
  String noticedDate;

  Notice(this.emoji, this.notice, this.noticedDate);
}

class NoticeTile extends StatelessWidget {

  NoticeTile(this._notice);

  final Notice _notice;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_notice.emoji,style: TextStyle(fontSize: 25))
        ],
      ),
      title: Text(_notice.notice),
      subtitle: Text(_notice.noticedDate),
    );
  }

}