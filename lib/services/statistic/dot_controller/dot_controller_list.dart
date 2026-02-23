import 'package:apka_mgr/models/dot_controller_model.dart';
import 'package:apka_mgr/services/statistic/dot_controller/dot_controller_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DotFilter {one, two, three, four, five, all}

class DotControllerList extends StatefulWidget {
  const DotControllerList({super.key});

  @override
  State<DotControllerList> createState() => _DotControllerListState();
}

class _DotControllerListState extends State<DotControllerList> {
  DotFilter _selectedDotNumber = DotFilter.all;

  @override
  Widget build(BuildContext context) {
    final dotControllerSnapshot = Provider.of<List<DotControllerModel>?>(context);

    if (dotControllerSnapshot == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredData = _filterData(dotControllerSnapshot);
    return Column(
      children: [
        _filterButtons(),
        Expanded(
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              return DotControllerListTile(
                dotControllerModel: filteredData[index],
              );
            },
          ),
        ),
      ],
    );
  } 

  Widget _filterButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        children: [
          _chip("Wszystkie", DotFilter.all),
          _chip("1 kropka", DotFilter.one),
          _chip("2 kropki", DotFilter.two),
          _chip("3 kropki", DotFilter.three),
          _chip("4 kropki", DotFilter.four),
          _chip("5 kropki", DotFilter.five),
        ],
      ),
    );
  }

  List<DotControllerModel> _filterData(List<DotControllerModel> data) {
    switch (_selectedDotNumber) {
      case DotFilter.one:
        return data.where((e) => e.controlledDots == '1').toList();
      case DotFilter.two:
        return data.where((e) => e.controlledDots == '2').toList();
      case DotFilter.three:
        return data.where((e) => e.controlledDots == '3').toList();
      case DotFilter.four:
        return data.where((e) => e.controlledDots == '4').toList();
      case DotFilter.five:
        return data.where((e) => e.controlledDots == '5').toList();
      case DotFilter.all:
        return data;
    }
  }

  Widget _chip(String label, DotFilter level) {
    final screenSize = MediaQuery.of(context).size;
    Color bgColor;

    if (level == DotFilter.one) {
      bgColor = Color(0xFFB1BE4D);;
    } else if (level == DotFilter.two) {
      bgColor = Color(0xFF49BD87);
    } else if (level == DotFilter.three) {
      bgColor = Color(0xFF537CDC);
    } else if (level == DotFilter.four) {
      bgColor = Color(0xFF8077E7);
    } else if (level == DotFilter.five) {
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
      selected: _selectedDotNumber == level,
      onSelected: (_) {
        setState(() => _selectedDotNumber = level);
      },
    );
  }
}