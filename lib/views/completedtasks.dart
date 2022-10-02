import 'package:flutter/material.dart';
import 'package:todoapp/services/todolistservice.dart';

import '../models/Todomodel.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({Key? key}) : super(key: key);

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController discriptionEditingController = TextEditingController();
  final _formmKey = GlobalKey<FormState>();
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
                    onTap: () {
                      titleEditingController.text =
                          snapshot.data[index].title.toString();
                      discriptionEditingController.text =
                          snapshot.data[index].description.toString();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Stack(
                                children: <Widget>[
                                  Positioned(
                                    right: -40.0,
                                    top: -40.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _formmKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                              controller:
                                                  titleEditingController,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                labelText: 'Enter title',
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                              controller:
                                                  discriptionEditingController,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                labelText:
                                                    'Enter task description',
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            child: const Text("Submit"),
                                            onPressed: () {
                                              setState(() {
                                                updateToDO(
                                                    ToDoListModel(
                                                        title:
                                                            titleEditingController
                                                                .text
                                                                .toString(),
                                                        description:
                                                            discriptionEditingController
                                                                .text
                                                                .toString()),
                                                    snapshot.data[index].sId
                                                        .toString(),
                                                    context);
                                                titleEditingController.clear();
                                                discriptionEditingController
                                                    .clear();
                                              });
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
