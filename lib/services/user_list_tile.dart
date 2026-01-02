import 'package:flutter/material.dart';
import 'package:apka_mgr/models/user_model.dart';

// A widget to displays a user in a list tile format.
class UserListTile extends StatelessWidget {
  final UserModel user;

  const UserListTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(user.name),
        subtitle: Text('Email: ${user.email}\nAge: ${user.age}\nInfo: ${user.additionalInfo}'),
      ),
    );
  }
}