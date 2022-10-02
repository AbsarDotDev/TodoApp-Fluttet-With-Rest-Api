import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/views/Login.dart';
import '../models/Todomodel.dart';

getTasks(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("auth-token") == "") {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ));
  }
  final String? authtoken = prefs.getString('auth-token');
  var url = "http://10.0.2.2:5000/api/todolist/alltodo";
  var data = await http.get(
    Uri.parse(url),
    headers: {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods":
          "GET, PUT, PATCH, POST, DELETE, OPTIONS, ",
      "Content-Type": " application/json",
      "auth-token": authtoken.toString()
    },
  );
  var tasks = await jsonDecode(data.body);

  List<ToDoListModel> todolist = [];
  for (var i in tasks) {
    todolist.add(ToDoListModel.fromJson(i));
  }
  return todolist;
}

addTask(ToDoListModel todo, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("auth-token") == "") {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ));
  }
  final String? authtoken = prefs.getString('auth-token');
  final response = await http.post(
    Uri.parse('http://10.0.2.2:5000/api/todolist/createtodo'),
    headers: {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      "Content-Type": " application/json",
      "auth-token": authtoken.toString()
    },
    body: jsonEncode(todo.toJson()),
  );
  print("Result: ${response.body}");
}

updateToDO(ToDoListModel todoModel, String id, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString("auth-token") == "") {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ));
  }
  final String? authtoken = prefs.getString('auth-token');
  http.put(
    Uri.parse('http://10.0.2.2:5000/api/todolist/updatetodo/$id'),
    headers: <String, String>{
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      "Content-Type": " application/json",
      "auth-token": authtoken.toString()
    },
    body: jsonEncode(todoModel.toJson()),
  );
}
