import 'package:flowers_app/models/flower.dart';
import 'package:provider/provider.dart';

import 'flower_db_provider.dart';

class DbProvider {
  static const String dbName = 'flower_db.db';

  static void fillTestData(context){
    final provider = Provider.of<FlowerProvider>(context, listen: false);

    for(int i = 0; i < 10; i++){
      var flower = new Flower(title: "Test flower $i");
      //provider.insert(flower);
    }
  }
}