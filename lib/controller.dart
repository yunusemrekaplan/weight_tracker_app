import 'package:get/get.dart';
import 'package:weight_tracker_app/models/record.dart';
import 'package:weight_tracker_app/view-models/record_controller.dart';

class Controller extends GetxController {

  /*var records = <Record>[
    *//*Record(dateTime: DateTime.now(), weight: 80, note: 'AAA'),
    Record(dateTime: DateTime.now(), weight: 81, note: 'BBB'),
    Record(dateTime: DateTime.now(), weight: 82, note: 'CCC'),
    Record(dateTime: DateTime.now(), weight: 83, note: 'DDD'),*//*
  ].obs;

  void addRecord() {
    records.add(Record(id: 1, dateTime: DateTime.now(), weight: 70, note: 'XXXXX'));
  }

  void deleteRecord(Record record) {
    records.remove(record);
  }
  */


  final RecordController _recordController = RecordController.instance;
  late var records = <Record>[].obs;

  Controller() {
    getAllRecords().then((value) => records = value.obs);
  }

  Future<List<Record>> getAllRecords() async {
    return _recordController.getAllRecords();
  }

  void addRecord(Record record) async {
    print('addRecord');
    //await _recordController.addRecord(Record(dateTime: DateTime.now(), weight: 70, photoUrl: '', note: 'XXXXX'));
    await _recordController.addRecord(record);
    late Record temp;
    await getLastRecord().then((value) {
      temp = value;
    });
    records.add(temp);
    print(records.length.toString());
  }

  deleteRecord(Record record) async {
    await _recordController.deleteRecord(record.id);
    records.remove(record);
  }

  Future<Record> getLastRecord() async {
    final db = await RecordController.instance.database;
    final result = await db.rawQuery(
      'SELECT * FROM Records ORDER BY id DESC LIMIT 1',
    );
    if (result.isEmpty) {
      throw Exception('Tabloda kayıt bulunamadı!');
    }
    return Record.fromMap(result.first);
  }
}