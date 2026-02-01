import 'package:apka_mgr/models/catch_a_ball_model.dart';
import 'package:apka_mgr/services/statistic/catch_a_ball/catch_a_ball_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LevelFilter {easy, medium, hard, all}

class CatchABallList extends StatefulWidget {
  const CatchABallList({super.key});

  @override
  State<CatchABallList> createState() => _CatchABallListState();
}

class _CatchABallListState extends State<CatchABallList> {
  LevelFilter _selectedLevel = LevelFilter.all;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<List<CatchABallModel>?>(context);

    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredData = _filterData(data);

    return Column(
      children: [
        _buildFilterButtons(),
        Expanded(
          child: ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              return CatchABallListTile(
                catchABallModel: filteredData[index],
              );
            },
          ),
        ),
      ],
    );
  }

  // ⬇⬇⬇ DOKŁADNIE TUTAJ ⬇⬇⬇
  List<CatchABallModel> _filterData(List<CatchABallModel> data) {
    switch (_selectedLevel) {
      case LevelFilter.easy:
        return data.where((e) => e.numberOfBalls == 10).toList();
      case LevelFilter.medium:
        return data.where((e) => e.numberOfBalls == 15).toList();
      case LevelFilter.hard:
        return data.where((e) => e.numberOfBalls > 15).toList();
      case LevelFilter.all:
      default:
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
          _chip("Łatwy", LevelFilter.easy),
          _chip("Średni", LevelFilter.medium),
          _chip("Trudny", LevelFilter.hard),
        ],
      ),
    );
  }

  Widget _chip(String label, LevelFilter level) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedLevel == level,
      onSelected: (_) {
        setState(() => _selectedLevel = level);
      },
    );
  }
}



