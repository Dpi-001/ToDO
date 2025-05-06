import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/todo.dart';
import 'package:flutter_application_1/second_page.dart';
import 'package:dio/dio.dart';

class Homescreenpage extends StatefulWidget {
  Homescreenpage({super.key});

  @override
  State<Homescreenpage> createState() => _HomescreenpageState();
}

class _HomescreenpageState extends State<Homescreenpage> {
  fetchTodos() async {
    // Fetch todos from the server
    // This is just a placeholder for the actual implementation
    // You can use http package to fetch data from an API
    //map ma vako laii model ma hunxw
    final Dio dio = Dio();
    final response = await dio.get(
      "https://jsonplaceholder.typicode.com/todos",
    );
    for (var todo in response.data) {
      todos.add(Todo.fromMap(todo));
    }
    if (filter == "all") {
      return todos;
    } else if (filter == "completed") {
      return todos.where((todo) => todo.isCompleted).toList();
    } else if (filter == "pending") {
      return todos.where((todo) => !todo.isCompleted).toList();
    }
  }

  final GlobalKey<FormState> _todoformKey = GlobalKey();
  String filter = "all";

  String title = "";

  String description = "";

  List<Todo> todos = [
    // Todo(
    //   id: "1",
    //   title: 'Buy groceries',
    //   description: 'Milk, Bread, Eggs',
    //   isCompleted: false,
    // ),
    // Todo(
    //   id: "2",
    //   title: 'Walk the dog',
    //   description: 'Take the dog for a walk in the park',
    //   isCompleted: false,
    // ),
    // Todo(
    //   id: "3",
    //   title: 'Read a book',
    //   description: 'Finish reading the current book',
    //   isCompleted: false,
    // ),
    // Todo(
    //   id: "4",
    //   title: 'Workout',
    //   description: 'Go to the gym for a workout session',
    //   isCompleted: false,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete All Todos'),
                    content: Text('Are you sure you want to delete all todos?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            todos.clear();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {},
                              ),
                              behavior: SnackBarBehavior.floating,
                              content: Text('All todos deleted'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text('Delete All'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete_forever),
          ),
          IconButton(
            iconSize: 30,
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTodoPage()),
              );

              if (result != null && result is Todo) {
                setState(() {
                  todos.add(result);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Todo added from AppBar icon'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            icon: Icon(Icons.add),
          ),
        ],

        //add a button to navigate to the second page
      ),

      body:
          todos.isEmpty
              ? Center(
                child: Text(
                  'No todos yet!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              )
              : Column(
                children: [
                  Row(
                    children: [
                      ActionChip(
                        label: Text(
                          'All',
                          style: TextStyle(
                            color:
                                filter == "all" ? Colors.white : Colors.black,
                          ),
                        ),
                        backgroundColor:
                            filter == "all" ? Colors.blue : Colors.grey[300],
                        onPressed: () {
                          setState(() {
                            filter = 'all';
                          });
                        },
                      ),
                      ActionChip(
                        label: Text(
                          'Completed',
                          style: TextStyle(
                            color:
                                filter == "completed"
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        backgroundColor:
                            filter == "completed"
                                ? Colors.blue
                                : Colors.grey[300],
                        onPressed: () {
                          setState(() {
                            filter = 'completed';
                          });
                        },
                      ),
                      ActionChip(
                        label: Text(
                          'Pending',
                          style: TextStyle(
                            color:
                                filter == "pending"
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        backgroundColor:
                            filter == "pending"
                                ? Colors.blue
                                : Colors.grey[300],

                        onPressed: () {
                          setState(() {
                            filter = 'pending';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200,

                    child: FutureBuilder(
                      future: fetchTodos(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            todos = snapshot.data as List<Todo>;
                            return ListView.builder(
                              itemBuilder: (ctx, i) {
                                return ListTile(
                                  trailing: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Delete Todo'),
                                            content: Text(
                                              'Are you sure you want to delete this todo?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    todos.remove(todos[i]);
                                                  });
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Todo deleted',
                                                      ),
                                                      backgroundColor:
                                                          Colors.red,
                                                      behavior:
                                                          SnackBarBehavior
                                                              .floating,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                      duration: Duration(
                                                        seconds: 2,
                                                      ),
                                                    ),
                                                  );

                                                  Navigator.pop(context);
                                                },
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
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
                                  //double question mark diyera chai default value dinu parcha
                                  // jaba description null huncha ni tyo value aaucha
                                  //exclamatory mark also works but it will throw an error if the value is null
                                  subtitle: Text(
                                    todos[i].description ??
                                        " No description provided",
                                  ),
                                );
                              },
                              itemCount: todos.length,
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Text("Error $snapshot.error"));
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
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
