import 'package:apka_mgr/models/build_a_word_model.dart';
import 'package:apka_mgr/models/catch_a_ball_model.dart';
import 'package:apka_mgr/models/dot_controller_model.dart';
import 'package:apka_mgr/models/excercise_model.dart';
import 'package:apka_mgr/models/reflex_check_model.dart';
import 'package:apka_mgr/models/whack_a_mole_model.dart';
import 'package:apka_mgr/services/database.dart';
import 'package:apka_mgr/services/statistic/build_a_word/build_a_word_calendar_tile.dart';
import 'package:apka_mgr/services/statistic/catch_a_ball/catch_a_ball_calendar_tile.dart';
import 'package:apka_mgr/services/statistic/dot_controller/dot_controller_calendar_tile.dart';
import 'package:apka_mgr/services/statistic/dot_controller/dot_controller_list_tile.dart';
import 'package:apka_mgr/services/statistic/reflex_check/reflex_check_calendar_tile.dart';
import 'package:apka_mgr/services/statistic/whack_a_mole/whack_a_mole_calendar_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressJournal extends StatefulWidget {
  const ProgressJournal({super.key});

  
  @override
  State<ProgressJournal> createState() => _ProgressJournalState();
}

class _ProgressJournalState extends State<ProgressJournal> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    

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
            locale: 'pl_PL',
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

          
          Expanded(
            child: ListView(
             children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Uderz w krecika",
                  style: TextStyle(fontSize: screenSize.height * 0.025),),),
              
              StreamBuilder<List<WhackAMoleModel>?>(
                stream: DatabaseService(uid: uid).getDayWhackAMoleStats(_selectedDay), 
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  final data = snapshot.data!;

                  return Column(
                    children: data.map((e) => Center(
                      child: WhackAMoleCalendarTile(whackAMoleModel: e),
                    )
                    ).toList(),
                  );
                }
              ),
              
              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Złap piłkę",
                  style: TextStyle(fontSize: screenSize.height * 0.025),),),
              
              StreamBuilder<List<CatchABallModel>?>(
                stream: DatabaseService(uid: uid).getDayCatchABallStats(_selectedDay), 
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  final data = snapshot.data!;

                  return Column(
                    children: data.map((e) => Center(
                      child: CatchABallCalendarTile(catchABallModel: e)
                    )
                    ).toList(),
                  );
                }
                ),


              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Zbuduj słowo",
                  style: TextStyle(fontSize: screenSize.height * 0.025),),),
              
              StreamBuilder<List<BuildAWordModel>?>(
                stream: DatabaseService(uid: uid).getDayBuildAWordStats(_selectedDay), 
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  final data = snapshot.data!;

                  return Column(
                    children: data.map((e) => Center(
                      child: BuildAWordCalendarTile(buildAWordModel: e)
                    )
                    ).toList(),
                  );
                }
                ),
              
              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Sprawdź refleks",
                  style: TextStyle(fontSize: screenSize.height * 0.025),),),
              
              StreamBuilder<List<ReflexCheckModel>?>(
                stream: DatabaseService(uid: uid).getDayReflexCheckStats(_selectedDay), 
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  final data = snapshot.data!;

                  return Column(
                    children: data.map((e) => Center(
                      child: ReflexCheckCalendarTile(reflexCheckModel: e)
                    )
                    ).toList(),
                  );
                }
                ),
              
              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Ślędź kropkę",
                  style: TextStyle(fontSize: screenSize.height * 0.025),),),
              
              StreamBuilder<List<DotControllerModel>?>(
                stream: DatabaseService(uid: uid).getDayDotControllerStats(_selectedDay), 
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  final data = snapshot.data!;

                  return Column(
                    children: data.map((e) => Center(
                      child: DotControllerCalendarTile(dotControllerModel: e),
                    )
                    ).toList(),
                  );
                }
                ),

              Padding(
                padding: EdgeInsets.all(12),
                child: Text("Ćwiczenia",
                  style: TextStyle(fontSize: screenSize.height * 0.025),),),
              
              StreamBuilder<List<ExcerciseModel>?>(
                stream: DatabaseService(uid: uid).getDayExcercises(_selectedDay), 
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  final data = snapshot.data!;

                  return Column(
                    children: data.map((e) => Card(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text("Score: ${e.description}"),
                     ),
                    )
                    ).toList(),
                  );
                }
                ),




             ],
            ),
          ),
          
        ],
      ),
    );
  }
}