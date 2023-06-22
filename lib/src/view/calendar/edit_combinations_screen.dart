import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/calendar/calendar_provider.dart';

class EditCombinationsScreen extends StatelessWidget {
  const EditCombinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Takvim'),
      ),
      body: Center(
        child: Consumer<CalendarProvider>(
          builder: (context, calendarProvider, _) {
            return buildCalendarGetCombinationsBuilder(calendarProvider);
          },
        ),
      ),
    );
  }

  FutureBuilder<List<String>?> buildCalendarGetCombinationsBuilder(
      CalendarProvider calendarProvider) {
    return FutureBuilder<List<String>?>(
      future: calendarProvider.getCombinations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          final combinations = snapshot.data!;
          if (combinations.isEmpty) {
            return const Text('Hiç kombinasyon bulunamadı.');
          } else {
            return ListView.builder(
              itemCount: combinations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(combinations[index]),
                );
              },
            );
          }
        } else {
          return const Text('Veri bulunamadı.');
        }
      },
    );
  }
}
