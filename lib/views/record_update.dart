// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weight_tracker_app/view-models/controller.dart';
import 'package:weight_tracker_app/models/record.dart';
import 'package:weight_tracker_app/views/history.dart';
import 'package:weight_tracker_app/views/home.dart';

class RecordUpdateScreen extends StatefulWidget {
  late Record record;
  RecordUpdateScreen({Key? key, required this.record}) : super(key: key);

  @override
  State<RecordUpdateScreen> createState() => _RecordUpdateScreenState(record: record.obs.value);
}

class _RecordUpdateScreenState extends State<RecordUpdateScreen> {
  late Record record;

  _RecordUpdateScreenState({required  this.record});

  final Controller _controller = Get.find();
  TextEditingController noteController = TextEditingController();
  late double _selectedValue = record.weight;
  late DateTime _selectedDate = record.dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Info'),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Column _buildBody() {
    return Column(
      children: [
        _buildWeight(),
        _buildDatePicker(),
        _buildNote(),
        _buildSaveButton(),
      ],
    );
  }

  ElevatedButton _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        record.weight = _selectedValue;
        record.dateTime = _selectedDate;
        record.note = noteController.text;

        _controller.updateRecord(record);
        Get.close(0);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: _buildCardShape(),
      ),
      child: const Text('Save Record'),
    );
  }

  Card _buildNote() {
    return Card(
      shape: _buildCardShape(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _buildNoteRow(),
      ),
    );
  }

  Row _buildNoteRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildNoteStickyIcon(),
        _buildNoteText(),
      ],
    );
  }

  Expanded _buildNoteText() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: TextFormField(
          cursorHeight: 24.0,
          style: const TextStyle(
            fontSize: 20.0,
          ),
          decoration: InputDecoration(
            //hintText: _hintText,
            hintText: (record.note != null) ? record.note : 'Note',
            border: InputBorder.none,
          ),
          controller: noteController,
        ),
      ),
    );
  }

  Icon _buildNoteStickyIcon() {
    return const Icon(
      FontAwesomeIcons.noteSticky,
      size: 40,
    );
  }

  GestureDetector _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        await pickDate();
      },
      child: Card(
        shape: _buildCardShape(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _buildDatePickerRow(),
        ),
      ),
    );
  }

  Row _buildDatePickerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCalendarIcon(),
        _buildDateText(),
      ],
    );
  }

  Icon _buildCalendarIcon() {
    return const Icon(
      FontAwesomeIcons.calendar,
      size: 40,
    );
  }

  Expanded _buildDateText() {
    return Expanded(
      child: Text(
        DateFormat('EEE, MMM d').format(_selectedDate),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Future<void> pickDate() async {
    var initialDate = DateTime.now();
    _selectedDate = await _showDatePicker(initialDate) ?? _selectedDate;
    setState(() {
      _selectedDate;
    });
  }

  Future<DateTime?> _showDatePicker(DateTime initialDate) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate.subtract(const Duration(days: 365)),
      lastDate: initialDate.add(const Duration(days: 30)),
      builder: (context, child) {
        return _buildPickDateDarkTheme(child);
      },
    );
  }

  Theme _buildPickDateDarkTheme(Widget? child) {
    return Theme(
      data: ThemeData.light().copyWith(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black87,
          onPrimary: Colors.white,
          secondary: Colors.yellow,
          onSecondary: Colors.brown,
          error: Colors.red,
          onError: Colors.pink,
          background: Colors.grey,
          onBackground: Colors.blueGrey,
          surface: Colors.grey,
          onSurface: Colors.blueGrey,
        ),
      ),
      child: child ?? const Text(''),
    );
  }

  Card _buildWeight() {
    return Card(
      shape: _buildCardShape(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _buildWeightRow(),
      ),
    );
  }

  Row _buildWeightRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildWeightScaleIcon(),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildWeightPicker(),
            _buildChevronUpIcon(),
          ],
        ),
      ],
    );
  }

  Icon buildWeightScaleIcon() {
    return const Icon(
      FontAwesomeIcons.weightScale,
      size: 40,
    );
  }

  Icon _buildChevronUpIcon() {
    return const Icon(
      FontAwesomeIcons.chevronUp,
      size: 16,
    );
  }

  RoundedRectangleBorder _buildCardShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );
  }

  DecimalNumberPicker _buildWeightPicker() {
    return DecimalNumberPicker(
      axis: Axis.horizontal,
      //itemCount: 3,
      //itemWidth: 70,
      //step: 1,
      minValue: 20,
      maxValue: 180,
      value: _selectedValue,
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
      },
      //decoration: _buildWeightPickerDecoration(),
    );
  }

  BoxDecoration _buildWeightPickerDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey),
    );
  }

}
