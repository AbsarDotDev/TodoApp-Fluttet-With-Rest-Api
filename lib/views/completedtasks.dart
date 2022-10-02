import 'package:flutter/material.dart';
import 'package:todoapp/services/todolistservice.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({Key? key}) : super(key: key);

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTasks(context),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${snapshot.data[index].title}"),
                    subtitle: Text("${snapshot.data[index].description}"),
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
