import 'package:apka_mgr/models/reflex_check_model.dart';
import 'package:apka_mgr/services/statistic/reflex_check/reflex_check_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReflexCheckListDart extends StatefulWidget {
  const ReflexCheckListDart({super.key});

  @override
  State<ReflexCheckListDart> createState() => _ReflexCheckListDartState();
}

class _ReflexCheckListDartState extends State<ReflexCheckListDart> {
  @override
  Widget build(BuildContext context) {
    final reflexCheckSnapshot = Provider.of<List<ReflexCheckModel>?>(context);

    return ListView.builder(
      itemCount: reflexCheckSnapshot?.length ?? 0,
      itemBuilder: (context, index) {
        return ReflexCheckListTile(reflexCheckModel: reflexCheckSnapshot![index]);
      }
    );
  } 
}