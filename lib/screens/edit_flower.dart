
import 'package:flowers_app/components/date_picker.dart';
import 'package:flowers_app/components/day_of_week.dart';
import 'package:flowers_app/components/time_picker.dart';
import 'package:flowers_app/db/flower_db_provider.dart';
import 'package:flowers_app/models/day_of_week.dart';
import 'package:flowers_app/models/flower.dart';
import 'package:flowers_app/models/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EditFlowerScreen extends StatefulWidget {
  EditFlowerScreen({
    Key? key,
    required this.flower,
  }) : super(key: key);

  final Flower flower;

  @override
  _EditFlowerScreenState createState() => _EditFlowerScreenState();
}

class _EditFlowerScreenState extends State<EditFlowerScreen> {
  List<DayOfWeek> _daysOfWeek = [
    DayOfWeek(dayOfWeek: 0),
    DayOfWeek(dayOfWeek: 1),
    DayOfWeek(dayOfWeek: 2),
    DayOfWeek(dayOfWeek: 3),
    DayOfWeek(dayOfWeek: 4),
    DayOfWeek(dayOfWeek: 5),
    DayOfWeek(dayOfWeek: 6)
  ];

  final double fontSize = 15;

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FlowerProvider>(context);
    fill();

    //_height = MediaQuery.of(context).size.height;
    //_width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.flower.title),
      ),

      body: Center(
        //width: _width,
        //height: _height,
        //color: Colors.blueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Название:", style: TextStyle(fontSize: fontSize)),
            TextField(
              controller: titleController,
            ),
            Text("Поливать:", style: TextStyle(fontSize: fontSize)),
            Expanded(
              flex: 2,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: _daysOfWeek.length,
                itemBuilder: (_, index) {
                  return ListTile(
                      title: Text(_daysOfWeek[index].getTitle(), style: TextStyle(fontSize: 15)),
                      leading: Checkbox(
                        value: _daysOfWeek[index].checked,
                        onChanged: (var newValue) {
                          setState(() => _daysOfWeek[index].checked = newValue!);

                          _daysOfWeek.map((e) => print("${e.dayOfWeek} - ${e.checked}"));
                        },
                      ),
                      onTap: () {
                        setState(() => _daysOfWeek[index].checked = !_daysOfWeek[index].checked);
                        _daysOfWeek.map((e) => print("${e.dayOfWeek} - ${e.checked}"));
                      }
                  );
                } ,
              )
            ),
            Expanded(
              child: TimePicker(label: Text("Время нотификации:", style: TextStyle(fontSize: fontSize)))
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    child: Text("Отменить", style: TextStyle(fontSize: fontSize)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    child: Text("Сохранить", style: TextStyle(fontSize: fontSize)),
                    onPressed: () {
                      widget.flower.title = titleController.value.text;
                      provider.upsert(context, widget.flower);
                      Navigator.pop(context);
                    },
                  )
                )
              ]
            ),
          ],
        ),
      )
    );
  }

  void fill(){
    titleController.value = TextEditingValue(text: widget.flower.title);

    if (widget.flower.notifications != null && widget.flower.notifications!.length > 0){
      _daysOfWeek.map((d) {
        d.checked = widget.flower.notifications!.any((n) => n.dayOfWeek == d.dayOfWeek);
      });
    }
  }
}