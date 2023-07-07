import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker_app/controller.dart';
import 'package:weight_tracker_app/views/add_record.dart';
import 'package:weight_tracker_app/views/graph.dart';
import 'package:weight_tracker_app/views/history.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(Controller());
  final iconList = <IconData>[
    Icons.show_chart,
    Icons.history,
  ];
  int _currentTab = 0;
  Widget _currentScreen = const GraphScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Track Your Weight'),),
      body: _currentScreen,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to( () => const AddRecordView());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        height: Get.height / 12,
        activeColor: Colors.black,
        inactiveColor: Colors.white,
        backgroundColor: Colors.grey,
        icons: iconList,
        iconSize: 32,
        activeIndex: _currentTab,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          setState(() {
            _currentTab = index;
            _currentScreen = (index == 0) ? const GraphScreen() : const HistoryScreen();
          });
        }
      ),
    );
  }
}