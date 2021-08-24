import 'package:flutter/material.dart';

import 'package:sugar_client/view/create/widget/timePickerInput.dart';
import 'package:sugar_client/view/create/widget/datePickerInput.dart';
import 'package:textfield_tags/textfield_tags.dart';

class CreateFormFields extends StatefulWidget {
  final TextEditingController _placeController;
  final TextEditingController _descriptionController;
  final TextEditingController _dateController, _timeController;
  final List<String> _tags;

  CreateFormFields(this._placeController, this._descriptionController,
      this._tags, this._dateController, this._timeController);

  @override
  _CreateFormFieldsState createState() => _CreateFormFieldsState();
}

class _CreateFormFieldsState extends State<CreateFormFields> {
  List<String> _initTags;

  @override
  void initState() {
    if (widget._tags != null) {
      _initTags = List.from(widget._tags);
    }
  }

  @override
  Widget build(context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("날짜 *",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        SizedBox(height: 7),
        DatePickerInput(widget._dateController),
        SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("시간",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        SizedBox(height: 7),
        TimePickerInput(widget._timeController),
        SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("장소",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        SizedBox(height: 7),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(fontSize: 16, height: 0.5,color: Colors.black.withOpacity(0.3)),
            hintText: "장소를 입력해주세요.",
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
          keyboardType: TextInputType.text,
          controller: widget._placeController,
        ),
        SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("설명",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        SizedBox(height: 7),
        Container(
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: null,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(fontSize: 16, height: 0.5,color: Colors.black.withOpacity(0.3)),
              hintText: "설명 문구를 입력해주세요.",
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
            controller: widget._descriptionController,
          ),
        ),
        SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("태그",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        SizedBox(height: 7),
        TextFieldTags(
          initialTags: _initTags.isEmpty ? [] : _initTags,
          textFieldStyler: TextFieldStyler(
            textFieldFilledColor: Colors.white,
            textFieldFilled: true,
            hintText: "# 태그를 입력하세요.",
            hintStyle: TextStyle(fontSize: 16, height: 0.5,color: Colors.black.withOpacity(0.3)),
            helperText: null,
            textFieldFocusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 122, 255, 1),
                    style: BorderStyle.solid,
                    width: 1)),
            textFieldBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
            ),
            contentPadding: const EdgeInsets.all(15.0),
            textFieldEnabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.1),
                width: 1.0,
              ),
            ),
          ),
          tagsStyler: TagsStyler(
              showHashtag: true,
              //These are properties you can tweek for customization
              tagTextStyle: TextStyle(fontWeight: FontWeight.normal),
              tagDecoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(0.0),
              ),
              tagCancelIcon:
                  Icon(Icons.cancel, size: 18.0, color: Colors.grey[900]),
              tagPadding: const EdgeInsets.all(6.0)
              // EdgeInsets tagPadding = const EdgeInsets.all(4.0),
              // EdgeInsets tagMargin = const EdgeInsets.symmetric(horizontal: 4.0),
              // BoxDecoration tagDecoration = const BoxDecoration(color: Color.fromARGB(255, 74, 137, 92)),
              // TextStyle tagTextStyle,
              // Icon tagCancelIcon = const Icon(Icons.cancel, size: 18.0, color: Colors.green)
              ),
          onTag: (tag) {
            //This give you tags entered
            print('onTag ' + tag);
            widget._tags.add(tag);
          },
          onDelete: (tag) {
            print('onDelete ' + tag);
            widget._tags.remove(tag);
          },
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
