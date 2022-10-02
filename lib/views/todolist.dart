import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/models/Todomodel.dart';
import 'package:todoapp/services/todolistservice.dart';
import 'package:todoapp/views/completedtasks.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController discriptionEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auth-token', "");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.check_box_outlined),
              ),
              Tab(icon: Icon(Icons.check_box)),
            ],
          ),
          title: const Text('Drawer Demo'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              const ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                onTap: () {
                  logout();
                },
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: CompletedTasks(),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                    controller: titleEditingController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Enter title',
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                    controller: discriptionEditingController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Enter task description',
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  child: const Text("Submit"),
                                  onPressed: () {
                                    setState(() {
                                      addTask(
                                          ToDoListModel(
                                              title: titleEditingController.text
                                                  .toString(),
                                              description:
                                                  discriptionEditingController
                                                      .text
                                                      .toString()),
                                          context);
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
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
