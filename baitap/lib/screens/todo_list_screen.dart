import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../database/database_helper.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final TextEditingController _controller = TextEditingController();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  // Load todos from the database
  Future<void> _loadTodos() async {
    final todos = await _databaseHelper.getTodos();
    setState(() {
      _todos = todos;
    });
  }

  // Add a new todo item to the database
  Future<void> _addTodo() async {
    if (_controller.text.isEmpty) return;

    final todo = Todo(
      title: _controller.text,
      isCompleted: false,
    );
    await _databaseHelper.insertTodo(todo);
    _controller.clear();
    _loadTodos();  // Reload the list after adding a todo
  }

  // Toggle completion status of a todo item
  Future<void> _toggleTodo(Todo todo) async {
    final updatedTodo = Todo(
      id: todo.id,
      title: todo.title,
      isCompleted: !todo.isCompleted,
    );
    await _databaseHelper.updateTodo(updatedTodo);
    _loadTodos();  // Reload the list after updating a todo
  }

  // Delete a todo item from the database
  Future<void> _deleteTodo(int id) async {
    await _databaseHelper.deleteTodo(id);
    _loadTodos();  // Reload the list after deleting a todo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (bool? value) => _toggleTodo(todo),
                  ),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTodo(todo.id!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
