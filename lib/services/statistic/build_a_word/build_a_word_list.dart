import 'package:apka_mgr/models/build_a_word_model.dart';
import 'package:apka_mgr/services/statistic/build_a_word/build_a_word_list_tile.dart';
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
        return BuildAWordListTile(buildAWordModel: buildAWordSnapshot![index]);
      }
    );
  }
}