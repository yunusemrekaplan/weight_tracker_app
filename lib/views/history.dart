import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker_app/models/record.dart';
import 'package:weight_tracker_app/controller.dart';
import 'package:weight_tracker_app/widgets/record_list_tile.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final Controller _controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    List<Record> records = _controller.records;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('History'),
          actions: [
            IconButton(
              onPressed: () => _controller.addRecord(Record(
                  dateTime: DateTime.now(),
                  weight: 70,
                  photoUrl: '',
                  note: 'XXXXX')),
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: records.isEmpty
            ? Center(
                child: Container(
                  child: Text('Please Add Some Records'),
                ),
              )
            : ListView(
                physics: BouncingScrollPhysics(),
                children: records
                    .map((record) => RecordListTile(record: record))
                    .toList(),
              ),
      ),
    );
  }
}
