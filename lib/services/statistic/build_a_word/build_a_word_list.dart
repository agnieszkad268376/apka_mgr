import 'package:apka_mgr/models/build_a_word_model.dart';
import 'package:apka_mgr/services/statistic/build_a_word/build_a_word_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum WordFilter {easy, medium, hard, all}

class BuildAWordList extends StatefulWidget {
  const BuildAWordList({super.key});

  @override
  State<BuildAWordList> createState() => _BuildAWordListState();
}

class _BuildAWordListState extends State<BuildAWordList> {
  WordFilter _selectedWordLevel = WordFilter.all;

  @override
  Widget build(BuildContext context) {
    final buildAWordSnapshot = Provider.of<List<BuildAWordModel>?>(context);

    if (buildAWordSnapshot == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredData = _filterData(buildAWordSnapshot);

    return Column(
      children: [
        _fliterButtons(),
        Expanded(
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              return BuildAWordListTile(buildAWordModel: filteredData[index]);
            }
          ),
        ),
      ],
    );
  }

  List<BuildAWordModel> _filterData(List<BuildAWordModel> data) {
    switch (_selectedWordLevel) {
      case WordFilter.easy:
        return data.where((e) => e.level == 'easy').toList();
      case WordFilter.medium:
        return data.where((e) => e.level == 'medium').toList();
      case WordFilter.hard:
        return data.where((e) => e.level == 'hard').toList();
      case WordFilter.all:
        return data;
    }
  }

  Widget _fliterButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        children: [
          _chip("Wszystkie", WordFilter.all),
          _chip("Łatwe", WordFilter.easy),
          _chip("Średnie", WordFilter.medium),
          _chip("Trudne", WordFilter.hard),
        ],
      )
    );
  }

  Widget _chip(String label, WordFilter filter) {
    final screenSize = MediaQuery.of(context).size;
    Color bgColor;

    if (filter == WordFilter.easy) {
      bgColor =  Color(0xFF4DBE9C);
    } else if (filter == WordFilter.medium) {
      bgColor = Color(0xFF4996BD);
    } else if (filter == WordFilter.hard) {
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
              radius: 25,
              backgroundColor: bgColor,
            ),
            Text(label, style: TextStyle(fontSize: screenSize.height * 0.012),)
          ],
        ),
      ), 
      selected: _selectedWordLevel == filter,
      onSelected: (_) {
        setState(() {
          _selectedWordLevel = filter;
        });
      },
    );
  }
}