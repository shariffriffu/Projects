import 'package:flutter/material.dart';

class SimpleDatePicker extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const SimpleDatePicker({Key? key, this.onDateSelected}) : super(key: key);

  @override
  _SimpleDatePickerState createState() => _SimpleDatePickerState();
}

class _SimpleDatePickerState extends State<SimpleDatePicker> {
  late DateTime _selectedDate;
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _currentMonth = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 8),
        _buildCalendar(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
            });
          },
        ),
        Text(
          '${_currentMonth.month}/${_currentMonth.year}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            setState(() {
              _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
            });
          },
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    DateTime firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    int daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: daysInMonth,
      itemBuilder: (context, index) {
        DateTime day = DateTime(_currentMonth.year, _currentMonth.month, index + 1);
        bool isSelected = day == _selectedDate;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = day;
            });
            widget.onDateSelected?.call(day);
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFF1C3144) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}
