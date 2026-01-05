import 'package:apka_mgr/models/user_model.dart';
import 'package:apka_mgr/services/users/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    // provider is listening to the list of users from Firestore
    final usersSnapshot = Provider.of<List<UserModel>?>(context);
    if (usersSnapshot != null){
      // print each document data to console
      for (var user in usersSnapshot) {
        print('User ID: ${user.uid}, Email: ${user.email}, Name: ${user.name}, Age: ${user.age}, Additional Info: ${user.additionalInfo}');
      }
    }

    print(usersSnapshot);
    // List view of users
    return ListView.builder(
      itemCount: usersSnapshot?.length ?? 0,
      itemBuilder: (context, index) {
        // use the user at the current index
        final user = usersSnapshot?[index];
        // return a Tile for each user
        return UserListTile(user: usersSnapshot![index]);
      },
    );
  }
}