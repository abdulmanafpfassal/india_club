import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomHorizontalDatePicker extends StatefulWidget {
  final ValueChanged<DateTime>? onDateSelected;
  final Color selectionColor;
  final Color selectedTextColor;
  final DateTime initialSelectedDate;


  CustomHorizontalDatePicker({
    this.onDateSelected,
    this.selectionColor = Colors.orange,
    this.selectedTextColor = Colors.white,
    required this.initialSelectedDate,
  });

  @override
  _CustomHorizontalDatePickerState createState() =>
      _CustomHorizontalDatePickerState();
}

class _CustomHorizontalDatePickerState
    extends State<CustomHorizontalDatePicker> {
  late List<DateTime> dateList;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateList = _generateDateList();
    selectedDate = widget.initialSelectedDate;
  }

  List<DateTime> _generateDateList() {
    final List<DateTime> dates = [];
    final now = DateTime.now();

    // Remove the time component and set it to midnight (00:00:00)
    final currentDateWithoutTime = DateTime(now.year, now.month, now.day);

    for (int i = 0; i <= 100; i++) {
      final date = currentDateWithoutTime.add(Duration(days: i));
      log(date.toString());

      dates.add(date);
    }

    return dates;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dateList.length,
        itemBuilder: (context, index) {
          final date = dateList[index];
          log("????" + date.toString());
          log("?>>" + selectedDate.toString());
          final isSelected = date == selectedDate;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });

              if (widget.onDateSelected != null) {
                widget.onDateSelected!(selectedDate);
              }
            },
            child: Container(
              width: 50.w,
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected ? widget.selectionColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd').format(date),
                    style: TextStyle(
                      color: isSelected
                          ? widget.selectedTextColor
                          : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      color: isSelected
                          ? widget.selectedTextColor
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}