import 'package:Giyin/src/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../service/calendar/calendar_provider.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalendarProvider>(
      create: (context) => CalendarProvider(),
      child: SafeArea(
        child: Scaffold(
          body: Consumer<CalendarProvider>(
            builder: (context, calendarProvider, _) {
              return TableCalendar(
                firstDay: DateTime.utc(2019, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: calendarProvider.focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(calendarProvider.selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  calendarProvider.onDaySelected(selectedDay, focusedDay);
                },
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ElevatedButton(
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            child: Text(
              'Create Combination',
              style: kMediumBeyazText,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/createCombination');
            },
          ),
        ),
      ),
    );
  }
}
