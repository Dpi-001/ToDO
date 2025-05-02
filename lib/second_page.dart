import 'package:flutter/material.dart';
import '../model/todo.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter title'
                            : null,
                onSaved: (value) => title = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter description'
                            : null,
                onSaved: (value) => description = value!,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final newTodo = Todo(
                      id: DateTime.now().toString(),
                      title: title,
                      description: description,
                    );

                    Navigator.pop(context, newTodo);
                  }
                },
                child: Text('Save Todo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
