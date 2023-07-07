import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

class AddRecordView extends StatefulWidget {
  const AddRecordView({Key? key}) : super(key: key);

  @override
  State<AddRecordView> createState() => _AddRecordViewState();
}

class _AddRecordViewState extends State<AddRecordView> {
  int _selectedValue = 70;

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
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text('Datepicker Card'),
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

  Card _buildWeight() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
