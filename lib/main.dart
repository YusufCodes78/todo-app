import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> todos = [];
  TextEditingController titleController = TextEditingController();

  void addTodo() {
    setState(() {
      todos.insert(0, {'title': titleController.text, 'checked': false});
      titleController.text = '';
    });
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: titleController,
                    onFieldSubmitted: (val) {
                      addTodo();
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                        )),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: ElevatedButton(
                      onPressed: () {
                        addTodo();
                      },
                      child: Text("Add Todo", style: TextStyle(fontSize: 16))),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            todos.isEmpty
                ? const Text(
                    'No todos',
                    style: TextStyle(fontSize: 16),
                  )
                : SizedBox(
                    height: 200,
                    child: ListView.builder(
                        // shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Checkbox(
                                value: todos[index]['checked'],
                                onChanged: (val) {
                                  setState(() {
                                    todos[index]['checked'] = val;
                                  });
                                },
                              ),
                              Text(
                                todos[index]['title'],
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () {
                                    deleteTodo(index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.deepPurple,
                                  ))
                            ],
                          );
                        },
                        itemCount: todos.length),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
