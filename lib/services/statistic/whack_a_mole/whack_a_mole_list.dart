import 'package:apka_mgr/models/whack_a_mole_model.dart';
import 'package:apka_mgr/services/statistic/whack_a_mole/whack_a_mole_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LevelFilter {one, two, three, all}

class WhackAMoleList extends StatefulWidget {
  const WhackAMoleList({super.key});

  @override
  State<WhackAMoleList> createState() => _WhackAMoleListState();
}

class _WhackAMoleListState extends State<WhackAMoleList> {
  LevelFilter _selectedLevel = LevelFilter.all;

  @override
  Widget build(BuildContext context) {
    final whackAMollSnapshot = Provider.of<List<WhackAMoleModel>?>(context);

    if (whackAMollSnapshot == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredData = _filterData(whackAMollSnapshot);

    return Column(
      children:[
        _buildFilterButtons(),
        Expanded(
        child: ListView.builder(
          itemCount: filteredData.length,
          itemBuilder: (context, index) {
            return WhackAMoleListTile(whackAMoleModel: filteredData[index]);
          }
        ),
      ),]
    );
  }

  List<WhackAMoleModel> _filterData(List<WhackAMoleModel> data) {
    switch (_selectedLevel) {
      case LevelFilter.one:
        return data.where((e) => e.level == '1').toList();
      case LevelFilter.two:
        return data.where((e) => e.level == '2').toList();
      case LevelFilter.three:
        return data.where((e) => e.level == '3').toList();
      case LevelFilter.all:
        return data;
    }
  }

  Widget _buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        children: [
          _chip("Wszystkie", LevelFilter.all),
          _chip("wolny", LevelFilter.one),
          _chip("średni", LevelFilter.two),
          _chip("szybki", LevelFilter.three),
        ],
      ),
    );
  }

  Widget _chip(String label, LevelFilter level) {
    final screenSize = MediaQuery.of(context).size;
    Color bgColor;

    if (level == LevelFilter.one) {
      bgColor =  Color(0xFF4DBE9C);
    } else if (level == LevelFilter.two) {
      bgColor = Color(0xFF4996BD);
    } else if (level == LevelFilter.three) {
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
      selected: _selectedLevel == level,
      onSelected: (_) {
        setState(() => _selectedLevel = level);
      },
    );
  }

} 