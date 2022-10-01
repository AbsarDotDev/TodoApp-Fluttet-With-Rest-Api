import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:todoapp/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

// getUsers() async {
//   var url = "https://maaz-api.tga-edu.com/api/users";
//   var data = await http.get(Uri.parse(url));
//   var posts = await jsonDecode(data.body);

//   return UserModel.fromJson(posts);
// }

addUser(UserModel userModel) async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/api/auth/createuser'),
    headers: {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      "Content-Type": " application/json"
    },
    body: jsonEncode(userModel.toJson()),
  );
  final responseJson = json.decode(response.body);
  print("Result: ${response.body}");
  //return Post.fromJson(responseJson);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  //now set the token inside the shared_preferences Library
  //I assumed that the token is a field in the json response, but check it before!!
  await prefs.setString('auth-token', responseJson['authtoken']);
}

// updateUser(Data userModel, int id) async {
//   http.put(
//     Uri.parse('https://maaz-api.tga-edu.com/api/users/$id'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(userModel.toJson()),
//   );
// }

// deleteUser(int id) async {
//   http.delete(
//     Uri.parse('https://maaz-api.tga-edu.com/api/users/$id'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//   );
// }
