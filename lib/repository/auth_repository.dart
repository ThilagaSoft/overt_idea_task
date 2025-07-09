
import 'dart:convert';

import 'package:map_pro/database/local_db.dart';
import 'package:map_pro/model/country_model.dart';
import 'package:map_pro/model/user_model.dart';

class AuthRepository

{  final LocalDatabase db = LocalDatabase.instance;


Future<UserModel?> register(
      String username,
      String email,
      String phone,
      String password,
      Country countryData,
      ) async
{
    final existing = await db.getUserModelByEmail(email);
    if (existing != null)
    {
      throw Exception("User already exists");
    }

    final user =
    {
      "userName":username,
      "email":email,
      "mobile":phone,
      "password":password,
      'countryData': jsonEncode(countryData.toJson()),

    };

    final id = await db.insertUserModel(user);
    final userData = await db.getUserModelById(id);
    return userData;

}



Future<UserModel?> login(String email, String password) async {
  final user = await db.getUserModelByEmail(email);

  if (user == null)
  {
    throw Exception("User not found");
  }
  if (user.password != password)
  {
    throw Exception("Invalid password");
  }
  await db.saveSessionValue('loggedInUserId', user.id);

  return user;
}



}
