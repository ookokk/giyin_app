import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../service/calendar/calendar_provider.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalendarProvider>(
      create: (context) => CalendarProvider(),
      child: SafeArea(
        child: Scaffold(
          body: Consumer<CalendarProvider>(
            builder: (context, calendarProvider, _) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2019, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: calendarProvider.focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(calendarProvider.selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      calendarProvider.onDaySelected(selectedDay, focusedDay);
                    },
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                ],
              ));
            },
          ),
        ),
      ),
    );
  }
}
