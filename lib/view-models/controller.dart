import 'package:get/get.dart';
import 'package:weight_tracker_app/models/record.dart';
import 'package:weight_tracker_app/view-models/db_controller.dart';

class Controller extends GetxController {
  final DBController _dbController = DBController.instance;
  late RxList<Record> records;

  @override
  void onInit() {
    super.onInit();
    records = <Record>[].obs;
    getAllRecords().then((value) => records.value = value);
    print('onInit records');
    print(records);
  }

  Future<List<Record>> getAllRecords() async {
    print('get records');
    return _dbController.getAllRecords();
  }

  void addRecord(Record record) async {
    await _dbController.addRecord(record);
    Record temp = await getLastRecord();
    records.add(temp);
    records.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  deleteRecord(Record record) async {
    await _dbController.deleteRecord(record.id);
    records.remove(record);
  }

  updateRecord(Record record) async {
    await _dbController.updateRecord(record);
    int index = records.indexWhere((r) => r.id == record.id);
    if (index != -1) {
      records[index] = record;
    }
    records.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  getRecordById(Record record) async {
    return await _dbController.getRecordById(record);
  }

  Future<Record> getLastRecord() async {
    final db = await DBController.instance.database;
    final result = await db.rawQuery(
      'SELECT * FROM Records ORDER BY id DESC LIMIT 1',
    );
    if (result.isEmpty) {
      throw Exception('Tabloda kayıt bulunamadı!');
    }
    return Record.fromMap(result.first);
  }
}
