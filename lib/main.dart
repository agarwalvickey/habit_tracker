import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pro/task.dart';
import 'package:flutter_pro/task_manager.dart';

void main() {
  runApp(const MyApp());
}

task_manager TaskManager = new task_manager();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return home();
  }
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hi Vickey!'),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: TaskManager.arr.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.lightBlue, width: 2),
                  ),
                  child: Text(TaskManager.arr[index].title,
                      style: TextStyle(fontSize: 50)),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          isExtended: true,
          backgroundColor: Colors.green,
          onPressed: () {
            showDialog(
          context: context,
          builder: (context) {
          return form();
    });
            // task temp = new task(1, "7", "yi", "oiahso", "dopj");
            // setState(() {
            //   TaskManager.update_list(temp);
            // });
          },
          label: Icon(Icons.add),
        ),
      ),
    );
  }
}

class form extends StatefulWidget {
  const form({Key? key}) : super(key: key);
  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  TextEditingController title = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController createdate = TextEditingController();
  TextEditingController reminderdate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Column(
          children: [
            TextField(
              controller: title,
            ),
            TextField(
              controller: details,
            ),
            TextField(
              controller: createdate,
            ),
            TextField(
              controller: reminderdate,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Create'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class task extends StatefulWidget {
//   const task({Key? key}) : super(key: key);
//
//   @override
//   State<task> createState() => _taskState();
// }
//
// class _taskState extends State<task> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Text('task'),);
//   }
// }
