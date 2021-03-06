// ignore: import_of_legacy_library_into_null_safe
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {

  TimePicker({
    Key? key,
    required this.label
  }) : super(key: key);

  final Text label;
  final TimeOfDay time = TimeOfDay(hour: 00, minute: 00);

  @override
  _TimePickerState createState() => _TimePickerState(label, time);
}

class _TimePickerState extends State<TimePicker> {

  _TimePickerState(Text label, TimeOfDay selectedTime){
    this.label = label;

    if (selectedTime == null){
      this.selectedTime = TimeOfDay(hour: 00, minute: 00);
    }
    else {
      this.selectedTime = selectedTime;
    }
  }

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  Text? label;

  double _height = 100;
  double _width = 100;

  String? _setTime = "";

  String _hour = "", _minute = "", _time = "";

  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: selectedTime,
    ))!;
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Container(
        width: _width,
        height: _height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                label!,
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: _width / 1.7,
                    height: _height / 9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      onSaved: (var val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      decoration: InputDecoration(
                          disabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),
          ],
      )
    );
  }
}