import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker_app/average_records_controller.dart';
import 'package:weight_tracker_app/view-models/controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
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
      ),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    LineSeries<ChartData, String>(
                        dataSource: _buildChartDataList(),
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                  ],
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

    for (var key in _averageRecordsController.monthlyAverage.keys) {
      keys.add(key);
    }
    for (var value in _averageRecordsController.monthlyAverage.values) {
      values.add(value ?? 0);
    }
    for (int i = 0; i < 12; i++) {
      list.add(ChartData(keys[i], values[i]));
    }

    return list;
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
