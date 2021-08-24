import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sugar_client/view/create/createDDay.dart';

class DatePickerInput extends StatefulWidget {
  final TextEditingController _controller;

  DatePickerInput(this._controller);

  @override
  _DatePickerInputState createState() => _DatePickerInputState();
}

class _DatePickerInputState extends State<DatePickerInput> {
  /// Which holds the selected date
  /// Defaults to today's date.
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        });
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        widget._controller.text =
            DateFormat("yyyy'년' MM'월' dd'일'").format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onTap: () {
          _selectDate(context);
        },
        controller: widget._controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(fontSize: 16, height: 0.5,color: Colors.black.withOpacity(0.3)),
          hintText: "날짜를 선택해주세요.",
          contentPadding: const EdgeInsets.all(15.0),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(0, 122, 255, 1),
                  style: BorderStyle.solid,
                  width: 1)),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.1),
              width: 1.0,
            ),
          ),
          errorStyle: TextStyle(height: 0),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 1))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 1))),
        ),
        showCursor: true,
        readOnly: true,
        validator: (date) {
          if (date.isEmpty || date == null) {
            //스낵바
/*                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("제목을 넣어주세요"),
                  )
                );
                return "";*/
            if (!CreateDDay.checkValidation) {
              CreateDDay.checkValidation = true;
              Fluttertoast.showToast(
                  msg: "날짜을 입력해주세요",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            return "";
          }
          return null;
        },
      ),
    );
  }
}
