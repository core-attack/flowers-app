//@dart=2.9
import 'package:flowers_app/db/flower_db_provider.dart';
import 'package:flowers_app/db/notification_db_provider.dart';
import 'package:flowers_app/flowers_app.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/single_child_widget.dart';

void main() => runApp(MultiProvider(
    providers: providers,
    child: FlowersApp(),
  ));

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<FlowerProvider>(create: (_) => FlowerProvider()),
  ChangeNotifierProvider<NotificationItemProvider>(create: (_) => NotificationItemProvider()),
];

