
//import 'package:flutter/material.dart';
//
//class DayOfWeekItem extends StatefulWidget {
//  DayOfWeekItem({
//    Key? key,
//    required this.dayOfWeek,
//    required this.value,
//  }) : super(key: key);
//
//  final int dayOfWeek;
//  bool value;
//
//  @override
//  _DayOfWeekItemState createState() => _DayOfWeekItemState();
//}
//
//class _DayOfWeekItemState extends State<DayOfWeekItem> {
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//      title: Text(getTitle(widget.dayOfWeek), style: TextStyle(fontSize: 15)),
//      leading: Checkbox(
//        value: widget.value,
//        onChanged: (var newValue) {
//          setState(() => widget.value = newValue!);
//        },
//      ),
//      onTap: () {
//        setState(() => widget.value = !widget.value);
//      }
//    );
//  }
//
//  String getTitle(int dayOfWeek){
//    switch(dayOfWeek){
//      case 0: return "Понедельник";
//      case 1: return "Вторник";
//      case 2: return "Среда";
//      case 3: return "Четверг";
//      case 4: return "Пятница";
//      case 5: return "Суббота";
//      case 6: return "Воскресенье";
//      default: return "Понедельник";
//    }
//  }
//}
