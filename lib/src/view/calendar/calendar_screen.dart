import 'package:Giyin/src/constants/color.dart';
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(70, 50),
                        maximumSize: const Size(300, 50),
                        backgroundColor: CustomColors.kMaviAcik,
                        shape: const StadiumBorder()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Go To My Combinations',
                          style: kMediumBeyazText,
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.curtains_closed)
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/combinations');
                      print("kombinasyoıne");
                    },
                  ),
                ],
              ));
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(70, 50),
                maximumSize: const Size(300, 50),
                backgroundColor: CustomColors.kMaviAcik,
                shape: const StadiumBorder()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Combination',
                  style: kMediumBeyazText,
                ),
                const SizedBox(width: 16),
                const Icon(Icons.create)
              ],
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
