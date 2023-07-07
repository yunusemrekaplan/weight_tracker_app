import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class AddRecordView extends StatefulWidget {
  const AddRecordView({Key? key}) : super(key: key);

  @override
  State<AddRecordView> createState() => _AddRecordViewState();
}

class _AddRecordViewState extends State<AddRecordView> {
  int _selectedValue = 70;
  DateTime _selectedDate = DateTime.now();

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
        GestureDetector(
          onTap: () async {
            await pickDate();
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    FontAwesomeIcons.calendar,
                    size: 40,
                  ),
                  Expanded(
                    child: Text(
                      DateFormat('EEE, MMM d').format(_selectedDate),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text('Weight Card'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text('Save Record'),
        ),
      ],
    );
  }

  Future<void> pickDate() async {
    var initialDate = DateTime.now();
    _selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: initialDate.subtract(const Duration(days: 365)),
          lastDate: initialDate.add(const Duration(days: 30)),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme(
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
              )),
              child: child ?? Text(''),
            );
          },
        ) ??
        _selectedDate;
    setState(() {
      _selectedDate;
    });
  }

  Card _buildWeight() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              FontAwesomeIcons.weightScale,
              size: 40,
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                NumberPicker(
                  axis: Axis.horizontal,
                  //itemCount: 3,
                  //itemWidth: 70,
                  step: 1,
                  minValue: 20,
                  maxValue: 180,
                  value: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                const Icon(
                  FontAwesomeIcons.chevronUp,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
