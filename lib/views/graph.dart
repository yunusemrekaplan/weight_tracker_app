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
  final Controller _controller = Get.find();
  final AverageRecordsController _averageRecordsController = Get.find();

  @override
  Widget build(BuildContext context) {
    print('graph _averageRecordsController.records.length');
    print(_averageRecordsController.records.length);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Graph'),
      ),
      body: Column(
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
    );
  }



  List<ChartData> _buildChartDataList() {
    List<ChartData> list = <ChartData>[];

    //list.add(ChartData(key, value))
    return [
      // Bind data source
      ChartData('Jan', 35),
      ChartData('Feb', 28),
      ChartData('Mar', 34),
      ChartData('Apr', 32),
      ChartData('May', 40),
      ChartData('Jun', 40),
      ChartData('Jul', 40),
      ChartData('Aug', 40),
      ChartData('Sep', 40),
      ChartData('Oct', 40),
      ChartData('Nov', 40),
      ChartData('Dec', 40),
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
