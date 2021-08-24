import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:intl/intl.dart';

class TimePickerInput extends StatefulWidget {
  final TextEditingController _controller;
  TimePickerInput(this._controller);
  @override
  _TimePickerInputState createState() => _TimePickerInputState();
}

class _TimePickerInputState extends State<TimePickerInput> {
  var _time;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onTap: () {
          _showDatePicker();
        },
        controller: widget._controller,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(fontSize: 16, height: 0.5,color: Colors.black.withOpacity(0.3)),
            hintText: "시간을 선택해주세요.",
            contentPadding: const EdgeInsets.all(15.0),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 122, 255, 1),
                    style: BorderStyle.solid,
                    width: 1)),
            border: OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(const Radius.circular(5.0))),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.1),
              width: 1.0,
            ),
          ),
        ),
        showCursor: true,
        readOnly: true,
      ),
    );
  }

  void _showDatePicker() {
      if(widget._controller.text.isNotEmpty) {
        int hour = int.parse(widget._controller.text.split("시")[0]);
        int min = int.parse(widget._controller.text.split("시")[1].split("분")[0]);
        print(hour);
        print(min);
        _time = TimeOfDay(hour: hour,minute: min);
      }else {
        _time = TimeOfDay.now();
      }
      Future<TimeOfDay> selectedTime = showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        helpText: "시간을 선택하세요",
        context: context,
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child
          );
        },
        initialTime: _time);
      selectedTime.then((timeOfDay) {
          widget._controller.text="${timeOfDay.hour}시 ${timeOfDay.minute}분";
      }).catchError((onError) {
        print("취소 클릭"); // 날짜를 선택하지 않고 취소했을시 에러 발생함으로 예외 처리
      });
  }
}