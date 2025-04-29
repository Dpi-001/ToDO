import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/todo.dart';

class Homescreenpage extends StatefulWidget {
  Homescreenpage({super.key});

  @override
  State<Homescreenpage> createState() => _HomescreenpageState();
}

class _HomescreenpageState extends State<Homescreenpage> {
  final GlobalKey<FormState> _todoformKey = GlobalKey();

  String title = "";

  String description = "";

  List<Todo> todos = [
    Todo(
      id: "1",
      title: 'Buy groceries',
      description: 'Milk, Bread, Eggs',
      isCompleted: false,
    ),
    Todo(
      id: "2",
      title: 'Walk the dog',
      description: 'Take the dog for a walk in the park',
      isCompleted: false,
    ),
    Todo(
      id: "3",
      title: 'Read a book',
      description: 'Finish reading the current book',
      isCompleted: false,
    ),
    Todo(
      id: "4",
      title: 'Workout',
      description: 'Go to the gym for a workout session',
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To Do')),

      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return ListTile(
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  todos.remove(todos[i]);
                });
              },
              icon: Icon(Icons.delete),
            ),
            leading: Checkbox(
              value: todos[i].isCompleted,
              onChanged: (value) {
                setState(() {
                  todos[i].isCompleted = value!;
                });
              },
            ),
            title: Text(todos[i].title),
            subtitle: Text(todos[i].description),
          );
        },
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Form(
                      key: _todoformKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Add Todo',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Title',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: 'Enter a title',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a title';
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 16),
                            onSaved: (value) {
                              title = value!;
                            },
                            onTapOutside:
                                (event) => FocusScope.of(
                                  context,
                                ).requestFocus(FocusNode()),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            onTapOutside:
                                (event) => FocusScope.of(
                                  context,
                                ).requestFocus(FocusNode()),
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: 'Enter a detailed description',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              description = value!;
                            },
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (!_todoformKey.currentState!.validate()) {
                                    return;
                                  }
                                  _todoformKey.currentState!.save();
                                  setState(() {
                                    todos.add(
                                      Todo(
                                        id: todos.length.toString(),
                                        title: title,
                                        description: description,
                                      ),
                                    );
                                  });

                                  Navigator.pop(context);
                                },
                                child: Text('Add Todo'),
                              ),
                              Spacer(),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
