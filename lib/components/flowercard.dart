
import 'package:flowers_app/models/flower.dart';
import 'package:flowers_app/screens/edit_flower.dart';
import 'package:flutter/material.dart';

class FlowerCard extends StatefulWidget {
  const FlowerCard({
    Key? key,
    required this.flower,
  }) : super(key: key);

  final Flower flower;

  @override
  _FlowerCardState createState() => _FlowerCardState();
}

class _FlowerCardState extends State<FlowerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        //margin: EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(widget.flower.title, style: TextStyle(fontSize: 30)),
          subtitle: Text(widget.flower.getWatering(), style: TextStyle(fontSize: 15)),
          //leading: widget.flower.image,
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditFlowerScreen(flower: widget.flower))
              );
            },
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditFlowerScreen(flower: widget.flower))
            );
          },
          onLongPress: () => print("${widget.flower.title} - long press"),
        )
    );
  }
}
