import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:remind/task_manager.dart';
import 'package:remind/task.dart';
import 'database.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.initInjection();
  runApp(const MyApp());
}

task_manager TaskManager = new task_manager();

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home(),
    );
  }
}

class home extends StatefulWidget {
  const home({Key key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  callBack() {
    setState(() {
      _tasks=getElements();
    });
  }

  Future<List<Map<dynamic, dynamic>>> _tasks;
  @override
  void initState() {
    // SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {}));
    _tasks = getElements();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder'),
      ),
      body: Container(
          child: FutureBuilder<List<Map<dynamic, dynamic>>>(
              future: _tasks,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<dynamic, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.add),
                        title: Text(snapshot.data[index]['title'],textScaleFactor: 1.5,),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              snapshot.data[index]['reminder_time']
                            ),
                            // Text(s)

                            Icon(Icons.edit,color: Colors.grey,),
                            Icon(Icons.delete,color: Colors.red,),

                          ],
                        ),
                        subtitle: Text(snapshot.data[index]['detail']),
                        selected: true,
                        onTap: () {
                        },
                      )
                        ;
                    },
                  );
                }
              })),
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return form(callBack);
              });
        },
        label: Icon(Icons.add),
      ),
    );
  }
}

class form extends StatefulWidget {
  form(this.callback);
  Function callback;
  // const form({Key? key}) : super(key: key);
  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  TextEditingController title = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController createdate = TextEditingController();
  TextEditingController reminderdate = TextEditingController();
  var departureDate;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: new InputDecoration.collapsed(
                  hintText: 'Title'
              ),
              controller: title,
            ),
            TextField(
              decoration: new InputDecoration.collapsed(
                  hintText: 'Detail'
              ),
              controller: details,
            ),
            Container(
              child: DateTimePicker(
              validator: (value) => (value == null || value.isEmpty)
                  ? 'Required Field'
                  : null,
              type: DateTimePickerType.dateTime,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
              initialDate: DateTime.now(),
              dateLabelText: 'Reminder Date',
              timeLabelText: 'Reminder Time',
              onChanged: (value) {
                departureDate = DateTime.parse(value);

              },
            ),),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('EEE d MMM \n kk:mm').format(now);
                  String reminderDate = DateFormat('EEE d MMM \n kk:mm').format(departureDate);
                  inserttasks(details.text, title.text, reminderDate,
                     formattedDate );
                  widget.callback();
                  Navigator.pop(context);
                },
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
// Container(
// // height: 100,
// padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
// child: Card(
// elevation: 5,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10),
// side: BorderSide(color: Colors.lightBlue, width: 2),
// ),
// child: Row(
// children: [
// Container(
// height: 50,
// // constraints: BoxConstraints.expand(),
// padding: EdgeInsets.all(10),
// decoration: const BoxDecoration(
// color: Colors.blue,
// borderRadius: BorderRadius.all(Radius.circular(10))
// ),
// child: Text(
// snapshot.data[index]['title'][0].toUpperCase(),
// style: TextStyle(color: Colors.white),
// ),
// ),
// Column(
// children: [
// Container(
// padding: EdgeInsets.all(5),
// child: Text(
// snapshot.data[index]['title'],
// )
// ),
// Container(
// padding: EdgeInsets.all(5),
// child: Text(
// snapshot.data[index]['detail'],
// )
// )
// ],
// )
// ],
//
// )
// ),
// );

