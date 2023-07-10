import 'package:get/get.dart';
import 'package:weight_tracker_app/models/record.dart';
import 'package:weight_tracker_app/view-models/record_controller.dart';

class Controller extends GetxController {

  final RecordController _recordController = RecordController.instance;
  late var records = <Record>[].obs;

  Controller() {
    getAllRecords().then((value) => records = value.obs);
  }

  Future<List<Record>> getAllRecords() async {
    return _recordController.getAllRecords();
  }

  void addRecord(Record record) async {
    await _recordController.addRecord(record);
    late Record temp;
    await getLastRecord().then((value) {
      temp = value;
    });
    records.add(temp);
    for(int i=1; i<records.length; i++) {
      for(int j=0; j<records.length-i; j++) {
        if(records[j].dateTime.isAfter(records[j+1].dateTime)) {
          var temp = records[j+1];
          records[j+1] = records[j];
          records[j] = temp;
        }
      }
    }
  }

  deleteRecord(Record record) async {
    await _recordController.deleteRecord(record.id);
    records.remove(record);
  }

  updateRecord(Record record) async {
    await _recordController.updateRecord(record);
    /*for(var i in records.obs.value) {
      if(i.id == record.id) {
        i = record;
        break;
      }
    }*/
  }

  getRecordById(Record record) async {
    return await _recordController.getRecordById(record);
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