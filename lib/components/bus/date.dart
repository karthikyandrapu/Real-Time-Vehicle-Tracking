import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelection extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  DateSelection({required this.onDateSelected});

  @override
  _DateSelectionState createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  DateTime selectedDate = DateTime.now();
  DateTime today = DateTime.now();
  DateTime tomorrow = DateTime.now().add(Duration(days: 1));

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        widget.onDateSelected(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: _selectDate,
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 30,
              ),
              SizedBox(width: 15),
              Text(
                "${DateFormat('E, dd MMM').format(selectedDate)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedDate = today;
                  widget.onDateSelected(selectedDate);
                });
              },
              child: Text(
                "Today",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: selectedDate.isAtSameMomentAs(today)
                      ? Colors.blueAccent
                      : Colors.black,
                ),
              ),
            ),
            SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedDate = tomorrow;
                  widget.onDateSelected(selectedDate);
                });
              },
              child: Text(
                "Tomorrow",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: selectedDate.isAtSameMomentAs(tomorrow)
                      ? Colors.blueAccent
                      : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
