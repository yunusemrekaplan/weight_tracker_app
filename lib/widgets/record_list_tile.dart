import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:weight_tracker_app/controller.dart';
import 'package:weight_tracker_app/models/record.dart';

class RecordListTile extends StatelessWidget {
  final Record record;
  RecordListTile({Key? key, required this.record}) : super(key: key);

  final Controller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: ListTile(
          leading: _buildDate(),
          title: _buildWeight(),
          trailing: _buildIconButtons(),
        ),
      ),
    );
  }

  Row _buildIconButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: null,
          color: Colors.grey,
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _controller.deleteRecord(record),
          color: Colors.red,
        ),
      ],
    );
  }

  Center _buildWeight() => Center(
          child: Text(
        record.weight.toString(),
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ));

  Text _buildDate() => Text(DateFormat('EEE MMM d').format(record.dateTime));
}
