import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_tracker_app/average_records_controller.dart';
import 'package:weight_tracker_app/view-models/controller.dart';
import 'package:weight_tracker_app/views/home.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Controller _controller = Get.put(Controller());
  final AverageRecordsController _averageRecordsController = Get.put(AverageRecordsController.instance);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    for(int i=1; i<_controller.records.length; i++) {
      for(int j=0; j<_controller.records.length-i; j++) {
        if(_controller.records[j].dateTime.isAfter(_controller.records[j+1].dateTime)) {
          var temp = _controller.records[j+1];
          _controller.records[j+1] = _controller.records[j];
          _controller.records[j] = temp;
        }
      }
    }
    _averageRecordsController.build();
    print('main _averageRecordsController.records.length');
    print(_averageRecordsController.records.length);

    return GetMaterialApp(
      title: 'Weight Tracker',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
      ),
      home: Home(currentScreen: 0,),
      getPages: [],
    );
  }
}
