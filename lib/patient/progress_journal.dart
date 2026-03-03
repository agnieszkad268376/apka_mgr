import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressJournal extends StatefulWidget {
  const ProgressJournal({super.key});

  
  @override
  State<ProgressJournal> createState() => _ProgressJournalState();
}

class _ProgressJournalState extends State<ProgressJournal> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  
  List<String> tasks = [
    "Trening 💪",
    "Czytanie książki 📚",
    "Spacer 🚶‍♀️",
    "Nauka Fluttera 💻",
    "Spotkanie z koleżanką ☕",
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFE8DBCE),
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.1,
        backgroundColor: const Color(0xFF98B6EC),
        centerTitle: true,
        title: Text(
          'Kalendarz postępów',
          style: TextStyle(fontSize: screenSize.height * 0.035),
        ),
      ),
      body: Column(
        children: [

          
          TableCalendar(
            firstDay: DateTime(2025),
            lastDay: DateTime(2030),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) =>
                isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),

          Divider(),

          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Postępy z dnia: ${_selectedDay!.toLocal().toString().split(' ')[0]}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Icon(Icons.check_circle_outline),
                    title: Text(tasks[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}