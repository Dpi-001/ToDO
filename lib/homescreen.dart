import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/todo.dart';

class Homescreenpage extends StatelessWidget {
  Homescreenpage({super.key});

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
            leading: Checkbox(
              value: todos[i].isCompleted,
              onChanged: (value) {},
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
            builder: (context) {
              return Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle form submission
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
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
