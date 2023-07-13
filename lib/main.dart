import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_tracker_app/average_records_controller.dart';
import 'package:weight_tracker_app/view-models/controller.dart';
import 'package:weight_tracker_app/views/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Controller _controller = Get.put(Controller());
  final AverageRecordsController _averageRecordsController =
      Get.put(AverageRecordsController.instance);

  final Future<dynamic> _calculation = Future<dynamic>.delayed(
    const Duration(milliseconds: 1700),
    () => Get.off(Home(currentScreen: 0)),//Get.to(Home(currentScreen: 0)),
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weight Tracker',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
      ),
      home: _buildFutureBuilder(),
      //getPages: [],
    );
  }

  FutureBuilder<dynamic> _buildFutureBuilder() {
    return FutureBuilder<dynamic>(
      future: _calculation, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) => _buildBuilder(snapshot, context),
    );
  }

  Center _buildBuilder(AsyncSnapshot<dynamic> snapshot, BuildContext context) {
    List<Widget> children;
    if (snapshot.hasData) {
      children = _buildHasData(snapshot);
    } else if (snapshot.hasError) {
      children = _buildHasError(snapshot);
    } else {
      children = _buildHasWaiting(context);
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  List<Widget> _buildHasWaiting(BuildContext context) {
    return <Widget>[
      Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: Colors.white,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hoş Geldiniz...',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    decorationColor: Colors.white),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildHasError(AsyncSnapshot<dynamic> snapshot) {
    return <Widget>[
      const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Error: ${snapshot.error}'),
      ),
    ];
  }

  List<Widget> _buildHasData(AsyncSnapshot<dynamic> snapshot) {
    return <Widget>[
      const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Result: ${snapshot.data}'),
      ),
    ];
  }
}
