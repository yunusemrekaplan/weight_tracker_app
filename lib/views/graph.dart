import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker_app/controller.dart';
import 'package:d_chart/d_chart.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final Controller _controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    DateTime temp = DateTime.now();

    print(temp.month);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Graph'),),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: DChartLine(
                data: [
                  {
                    'id': 'Line',
                    'data': [
                      {'domain': 0, 'measure': 4.1},
                      {'domain': 1, 'measure': 4},
                      {'domain': 2, 'measure': 6},
                      {'domain': 3, 'measure': 1},
                    ],
                  },
                ],
                lineColor: (lineData, index, id) => Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
