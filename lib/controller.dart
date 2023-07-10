import 'package:get/get.dart';
import 'package:weight_tracker_app/models/record.dart';
import 'package:weight_tracker_app/view-models/record_controller.dart';

class Controller extends GetxController {
  final RecordController _recordController = RecordController.instance;
  late RxList<Record> records;

  @override
  void onInit() {
    super.onInit();
    records = <Record>[].obs;
    getAllRecords().then((value) => records.value = value);
  }

  Future<List<Record>> getAllRecords() async {
    return _recordController.getAllRecords();
  }

  void addRecord(Record record) async {
    await _recordController.addRecord(record);
    Record temp = await getLastRecord();
    records.add(temp);
    records.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  deleteRecord(Record record) async {
    await _recordController.deleteRecord(record.id);
    records.remove(record);
  }

  updateRecord(Record record) async {
    await _recordController.updateRecord(record);
    int index = records.indexWhere((r) => r.id == record.id);
    if (index != -1) {
      records[index] = record;
      print("bulundu");
      print(record.weight);
      print(records[index].weight);
    }
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
