import 'package:apka_mgr/models/build_a_word_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildAWordList extends StatefulWidget {
  const BuildAWordList({super.key});

  @override
  State<BuildAWordList> createState() => _BuildAWordListState();
}

class _BuildAWordListState extends State<BuildAWordList> {
  @override
  Widget build(BuildContext context) {
    final buildAWordSnapshot = Provider.of<List<BuildAWordModel>?>(context);

    return ListView.builder(
      itemCount: buildAWordSnapshot?.length ?? 0,
      itemBuilder: (context, index) {
        final buildAWordStat = buildAWordSnapshot?[index];
        return ListTile(
          title: Text('Data: ${buildAWordStat!.date}'),
          subtitle: Text('Wynik ${buildAWordStat.score}'),
        );
      }
    );
  }
}