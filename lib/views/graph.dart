import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker_app/average_records_controller.dart';
import 'package:weight_tracker_app/view-models/controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final Controller _controller = Get.find();
  final AverageRecordsController _averageRecordsController = Get.find();

  @override
  void initState() {
    _averageRecordsController.build();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Graph'),
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 2.5,
              child: Padding(
                padding: const EdgeInsets.only(top: 64.0),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    LineSeries<ChartData, String>(
                      dataSource: _buildChartDataList(),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: _buildCardShape(),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _controller.records.isNotEmpty
                          ? Text(
                              _controller.records.first.weight.toString(),
                              style: const TextStyle(
                                fontSize: 32.0,
                              ),
                            )
                          : const Text(''),
                      const Text('Current Weight'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ChartData> _buildChartDataList() {
    List<ChartData> list = <ChartData>[];
    List<String> keys = <String>[];
    List<double> values = <double>[];
    //bool control = true;

    for (var key in _averageRecordsController.monthlyAverage.keys) {
      keys.add(key);
    }
    for (var value in _averageRecordsController.monthlyAverage.values) {
      values.add(value ?? 0);
    }
    for (int i = 0; i < 12; i++) {
      if (values[i] != 0) {
        //control = false;
        list.add(ChartData(keys[i], values[i]));
      }
    }

    /*
    if (control) {
      return [
        ChartData('Jan', 0),
        ChartData('Feb', 0),
        ChartData('Mar', 0),
      ];
    }
  */

    return list;
  }

  RoundedRectangleBorder _buildCardShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
