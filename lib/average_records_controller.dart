import 'package:get/get.dart';
import 'package:weight_tracker_app/view-models/controller.dart';
import 'package:weight_tracker_app/models/record.dart';

class AverageRecordsController extends GetxController {
  final Controller _controller = Get.find();

  late RxList<Record> records;
  late List<Record> janRecords;
  late List<Record> febRecords;
  late List<Record> marRecords;
  late List<Record> aprRecords;
  late List<Record> mayRecords;
  late List<Record> junRecords;
  late List<Record> julRecords;
  late List<Record> augRecords;
  late List<Record> sepRecords;
  late List<Record> octRecords;
  late List<Record> novRecords;
  late List<Record> decRecords;
  late RxMap<String, double?> monthlyAverage;
  late double sumAverage;

  static AverageRecordsController instance = AverageRecordsController._internal();

  factory AverageRecordsController() {
    return instance;
  }

  AverageRecordsController._internal() {
    build();
  }

  void build() {
    records = <Record>[].obs;
    records = _controller.records;
    _controller.getAllRecords().then((value) => records.value = value);

    janRecords = <Record>[];
    febRecords = <Record>[];
    marRecords = <Record>[];
    aprRecords = <Record>[];
    mayRecords = <Record>[];
    junRecords = <Record>[];
    julRecords = <Record>[];
    augRecords = <Record>[];
    sepRecords = <Record>[];
    octRecords = <Record>[];
    novRecords = <Record>[];
    decRecords = <Record>[];

    for (var record in records) {
      switch (record.dateTime.month) {
        case 1:
          janRecords.add(record);
          break;
        case 2:
          febRecords.add(record);
          break;
        case 3:
          marRecords.add(record);
          break;
        case 4:
          aprRecords.add(record);
          break;
        case 5:
          mayRecords.add(record);
          break;
        case 6:
          junRecords.add(record);
          break;
        case 7:
          julRecords.add(record);
          break;
        case 8:
          augRecords.add(record);
          break;
        case 9:
          sepRecords.add(record);
          break;
        case 10:
          octRecords.add(record);
          break;
        case 11:
          novRecords.add(record);
          break;
        case 12:
          decRecords.add(record);
          break;
      }
    }

    sumAverage = getWeightAverage(records);

    monthlyAverage = {
      'Jan': getWeightAverage(janRecords),
      'Feb': getWeightAverage(febRecords),
      'Mar': getWeightAverage(marRecords),
      'Apr': getWeightAverage(aprRecords),
      'May': getWeightAverage(mayRecords),
      'Jun': getWeightAverage(junRecords),
      'Jul': getWeightAverage(julRecords),
      'Aug': getWeightAverage(augRecords),
      'Sep': getWeightAverage(sepRecords),
      'Oct': getWeightAverage(octRecords),
      'Nov': getWeightAverage(novRecords),
      'Dec': getWeightAverage(decRecords),
    }.obs;
    print(monthlyAverage);
  }

  double getWeightAverage(List<Record> records) {
    if (records.isEmpty) return 0;

    double sum = 0;
    for (var record in records) {
      sum += record.weight;
    }
    return sum / records.length;
  }
}
//TODO: Yıl sonu veriler silinmeli!!!!
//TODO: Kayıtlarda herangi bir değişiklik(add, delete, update) yapıldığı zaman kayıt verilleri yenilenmelidir. Her uygulama açıldığında tekrar tekrar yapılmamalıdır.
