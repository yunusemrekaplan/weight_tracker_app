import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weight_tracker_app/view-models/controller.dart';
import 'package:weight_tracker_app/models/record.dart';

class AddRecordView extends StatefulWidget {
  const AddRecordView({Key? key}) : super(key: key);

  @override
  State<AddRecordView> createState() => _AddRecordViewState();
}

class _AddRecordViewState extends State<AddRecordView> {
  double _selectedValue = 70;
  DateTime _selectedDate = DateTime.now();

  TextEditingController noteController = TextEditingController();
  final Controller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Record'),
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
        _controller.addRecord(
          Record(
            dateTime: _selectedDate,
            weight: _selectedValue,
            note: noteController.text,
          ),
        );
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
          decoration: const InputDecoration(
            hintText: 'Note',
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
        _buildWeightPicker(),
        const Center(),
      ],
    );
  }

  Icon buildWeightScaleIcon() {
    return const Icon(
      FontAwesomeIcons.weightScale,
      size: 40,
    );
  }

  RoundedRectangleBorder _buildCardShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );
  }

  DecimalNumberPicker _buildWeightPicker() {
    return DecimalNumberPicker(
      itemHeight: 35,
      itemWidth: 45,
      minValue: 20,
      maxValue: 180,
      value: _selectedValue,
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
      },
      integerDecoration: _buildWeightPickerDecoration(),
      decimalDecoration: _buildWeightPickerDecoration(),
      selectedTextStyle: const TextStyle(color: Colors.blue, fontSize: 22),
    );
  }

  BoxDecoration _buildWeightPickerDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey, width: 0.4),
    );
  }
}
