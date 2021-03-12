import 'package:flutter/material.dart';

import 'notification_item.dart';

class Flower {
  static const String tableName = 'flowers';
  static const String columnId = '_id';
  static const String columnTitle = 'title';
  static const String columnImagePath = 'imagePath';

  int? id;
  String title = "test flower";
  Image? image;
  List<NotificationItem>? notifications;

  Flower({this.title = ""});

  String getWatering(){
    if (notifications == null){
      return "";
    }

    return notifications?.map((n) => n.getShortDayOfWeek()).join(" ") as String;
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnTitle: title,
      //columnImagePath: image
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Flower.fromMap(Map<dynamic, dynamic> map) {
    id = map[columnId] as int?;
    title = map[columnTitle] as String;
    //image = map[columnDone] == 1;
  }
}