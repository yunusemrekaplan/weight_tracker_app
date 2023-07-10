import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:weight_tracker_app/controller.dart';
import 'package:weight_tracker_app/models/record.dart';
import 'package:weight_tracker_app/views/record_update.dart';

class RecordListTile extends StatelessWidget {
  final Record record;
  RecordListTile({Key? key, required this.record}) : super(key: key);

  final Controller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: _buildCardShape(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: ListTile(
          title: _buildDateAndWeight(),
          trailing: _buildIconButtons(),
        ),
      ),
    );
  }

  RoundedRectangleBorder _buildCardShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );
  }

  Row _buildIconButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildEditIconButton(),
        _buildDeleteIconButton(),
      ],
    );
  }

  IconButton _buildDeleteIconButton() {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () => _controller.deleteRecord(record),
      color: Colors.red,
    );
  }

  IconButton _buildEditIconButton() {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () => Get.to(RecordUpdateScreen(record: record)),
      color: Colors.grey,
    );
  }

  Row _buildDateAndWeight() {
    return Row(
      children: [
        _buildDate(),
        _buildWeight(),
      ],
    );
  }

  Flexible _buildWeight() {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Text(
        record.weight.toString(),
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  SizedBox _buildDate() {
    return SizedBox(
      height: 40,
      width: 110,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          DateFormat('EEE MMM d').format(record.dateTime),
          style: const TextStyle(fontSize: 19),
        ),
      ),
    );
  }
}
