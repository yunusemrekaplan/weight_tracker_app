import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker_app/controller.dart';
import 'package:weight_tracker_app/widgets/record_list_tile.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final Controller _controller = Get.find();
  //List<Record> records = <Record>[];

  @override
  void initState() {
    for(int i=1; i<_controller.records.length; i++) {
      for(int j=0; j<_controller.records.length-i; j++) {
        if(_controller.records[j].dateTime.isAfter(_controller.records[j+1].dateTime)) {
          var temp = _controller.records[j+1];
          _controller.records[j+1] = _controller.records[j];
          _controller.records[j] = temp;
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
        body: _controller.records.isEmpty ? _buildEmptyHistory() : _buildBody(),
      ),
    );
  }

  ListView _buildBody() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children:
      _controller.records.map((record) => RecordListTile(record: record)).toList(),
    );
  }

  Center _buildEmptyHistory() {
    return const Center(
      child: Text('Please Add Some Records'),
    );
  }
}
