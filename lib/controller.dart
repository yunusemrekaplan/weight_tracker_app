import 'package:get/get.dart';
import 'package:weight_tracker_app/models/record.dart';

class Controller extends GetxController {

  var records = <Record>[
    /*Record(dateTime: DateTime.now(), weight: 80, note: 'AAA'),
    Record(dateTime: DateTime.now(), weight: 81, note: 'BBB'),
    Record(dateTime: DateTime.now(), weight: 82, note: 'CCC'),
    Record(dateTime: DateTime.now(), weight: 83, note: 'DDD'),*/
  ].obs;

  void addRecord() {
    records.add(Record(dateTime: DateTime.now(), weight: 70, note: 'XXXXX'));
  }

  void deleteRecord(Record record) {
    records.remove(record);
  }
}