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
  final Controller _controller = Get.find();
  List<Record> records = <Record>[];

  @override
  void initState() {
    records = _controller.records;
    for(int i=1; i<records.length; i++) {
      for(int j=0; j<records.length-i; j++) {
        if(records[j].dateTime.isAfter(records[j+1].dateTime)) {
          var temp = records[j+1];
          records[j+1] = records[j];
          records[j] = temp;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('History'),
        ),
        body: records.isEmpty ? _buildEmptyHistory() : _buildBody(records),
      ),
    );
  }

  ListView _buildBody(List<Record> records) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children:
          records.map((record) => RecordListTile(record: record)).toList(),
    );
  }

  Center _buildEmptyHistory() {
    return Center(
      child: Container(
        child: Text('Please Add Some Records'),
      ),
    );
  }
}
