import 'package:flutter/material.dart';

class NotificationItem {

  static const String tableName = 'notifications';
  static const String columnId = '_id';
  static const String columnMessage = 'message';
  static const String columnDayOfWeek = 'dayOfWeek';
  static const String columnRepeatInWeeks = 'repeatInWeeks';
  static const String columnFlowerId = 'flowerId';

  int? id;
  String message = "test notification";
  TimeOfDay time = TimeOfDay.now();
  int dayOfWeek = 0; //0 - monday
  int repeatInWeeks = 1;
  int flowerId = 0;

  NotificationItem({required this.dayOfWeek});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnMessage: message,
      columnDayOfWeek: dayOfWeek,
      columnRepeatInWeeks: repeatInWeeks,
      columnFlowerId: flowerId
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  NotificationItem.fromMap(Map<dynamic, dynamic> map) {
    id = map[columnId] as int?;
    message = map[columnMessage] as String;
    dayOfWeek = map[columnDayOfWeek] as int;
    repeatInWeeks = map[columnRepeatInWeeks] as int;
    flowerId = map[columnFlowerId] as int;
  }

  String getShortDayOfWeek(){
    switch(dayOfWeek){
      case 0: return "Пн";
      case 1: return "Вт";
      case 2: return "Ср";
      case 3: return "Чт";
      case 4: return "Пт";
      case 5: return "Сб";
      case 6: return "Вс";
      default: return "Пн";
    }
  }
}