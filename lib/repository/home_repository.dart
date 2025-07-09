
import 'dart:convert';

import 'package:map_pro/database/local_db.dart';
import 'package:map_pro/model/user_model.dart';

class HomeRepository
{

final LocalDatabase db = LocalDatabase.instance;

Future<UserModel?> getUserDetails() async
{
  final userID = await db.getSessionValue('loggedInUserId');

  print("Login Get: $userID");
  final user = await db.getUserModelById(userID);

  if (user == null)
  {
    print("User not found");
    throw Exception("User not found");
  }
  else
  {
    print("User found: ${user}");

    print("User get  successful");
    return user;
  }

}
Future<void> logout() async
{
  await db.removeSessionKey('loggedInUserId');
}


}
