import 'package:apka_mgr/models/reflex_check_model.dart';
import 'package:apka_mgr/services/statistic/reflex_check/reflex_check_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ReflexFilter {threeRounds, fiveRounds, sevenRounds, all}

class ReflexCheckListDart extends StatefulWidget {
  const ReflexCheckListDart({super.key});

  @override
  State<ReflexCheckListDart> createState() => _ReflexCheckListDartState();
}

class _ReflexCheckListDartState extends State<ReflexCheckListDart> {
  ReflexFilter _selectedRounds = ReflexFilter.all;

  @override
  Widget build(BuildContext context) {
    final reflexCheckSnapshot = Provider.of<List<ReflexCheckModel>?>(context);
    
    if (reflexCheckSnapshot == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredData = _filterData(reflexCheckSnapshot);

    return Column(
      children:[
        _filterButtons(),
        Expanded(
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              return ReflexCheckListTile(reflexCheckModel: filteredData[index]);
            }
          ),
        ),
      ],
    );
  } 

  List<ReflexCheckModel> _filterData(List<ReflexCheckModel> data) {
    switch (_selectedRounds) {
      case ReflexFilter.threeRounds:
        return data.where((e) => e.roundsPlayed == 3).toList();
      case ReflexFilter.fiveRounds:
        return data.where((e) => e.roundsPlayed == 5).toList();
      case ReflexFilter.sevenRounds:
        return data.where((e) => e.roundsPlayed == 7).toList();
      case ReflexFilter.all:
        return data;
    }
  }

  Widget _filterButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        children: [
          _chip("Wszystkie", ReflexFilter.all),
          _chip("3 rundy", ReflexFilter.threeRounds), 
          _chip("5 rund", ReflexFilter.fiveRounds),
          _chip("7 rund", ReflexFilter.sevenRounds),
        ],
      ),
    );
  }

  Widget _chip(String label, ReflexFilter level) {
    final screenSize = MediaQuery.of(context).size;
    Color bgColor;

    if (level == ReflexFilter.threeRounds) {
      bgColor =  Color(0xFF4DBE9C);
    } else if (level == ReflexFilter.fiveRounds) {
      bgColor = Color(0xFF4996BD);
    } else if (level == ReflexFilter.sevenRounds) {
      bgColor = Color(0xFF9E579E);
    } else {
      bgColor = Color.fromARGB(255, 55, 55, 55);
    }
    
    return ChoiceChip(
      label: SizedBox(
        width: screenSize.width * 0.15,
        height: screenSize.height * 0.02,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundColor: bgColor,
            ),
            Text(label, style: TextStyle(fontSize: screenSize.height * 0.012)),
          ],
        ),
      ),
      selected: _selectedRounds == level,
      onSelected: (_) {
        setState(() => _selectedRounds = level);
      },
    );
  }
}