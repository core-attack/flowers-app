
import 'package:flowers_app/components/flowercard.dart';
import 'package:flowers_app/db/db_provider.dart';
import 'package:flowers_app/db/flower_db_provider.dart';
import 'package:flowers_app/models/flower.dart';
import 'package:flowers_app/screens/edit_flower.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    DbProvider.fillTestData(context);

    final provider = Provider.of<FlowerProvider>(context, listen: false);
    provider.getAll(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlowerProvider>(context);

    return Scaffold(
      body: provider.loading
          ? CircularProgressIndicator()
          : ListView.separated(
          physics: ClampingScrollPhysics(),
          itemCount: provider.entities.length,
          itemBuilder: (_, index) => FlowerCard(flower: provider.entities[index]),
          separatorBuilder: (_, __) => Divider()
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditFlowerScreen(flower: new Flower()))
          );
        },
      ),
    );
  }
}