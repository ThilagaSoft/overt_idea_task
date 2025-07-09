import 'package:flutter/material.dart';
import 'package:map_pro/database/local_db.dart';

class InitController
{
  Future<void> handleRedirection(BuildContext context) async
  {
    final userId = await LocalDatabase.instance.getSessionValue('loggedInUserId');
    final route = userId != null ? '/home' : '/login';
    Navigator.pushReplacementNamed(context, route);
  }
}
