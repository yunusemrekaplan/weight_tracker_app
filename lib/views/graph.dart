import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker_app/controller.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final Controller _controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Graph'),),
      body: const Center(child: Text('Graph Screen')),
    );
  }
}
