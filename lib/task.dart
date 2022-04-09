
import 'database.dart';

class task{
  final int id;
  final String detail;
  final String title;
  final String reminder_time;
  final String created_time;
  task({this.id, this.detail, this.title, this.reminder_time, this.created_time});
  Map<String, dynamic> tomap() {
    return {
      "detail": detail,
      "title": title,
      "reminder_time": reminder_time,
      "created_time": created_time,
    };
  }
  fromMap(Map<String, dynamic> json) => task(
      id: json['id'],
      detail: json['detail'],
      title: json['title'],
      reminder_time: json['reminder_time'],
      created_time: json['created_time']
  );

  }
DatabaseHelper _databaseHelper = Injection.injector.get();

Future<int> inserttasks(
    String detail,
    String title,
    String reminder_time,
    String created_time
    ) async {
  final todo = task(
    detail: detail,
    title: title,
    reminder_time: reminder_time,
    created_time: created_time,
  );
  print(todo.detail);
  //databaseHelper has been injected in the class
  int sn = await _databaseHelper.db.insert('task', todo.tomap());
  print('Inserted');
  print(sn);
  return sn;
}

Future<List<Map<dynamic, dynamic>>> getElements() async {
  //databaseHelper has been injected in the class
  List<Map> list = (await _databaseHelper.db
      .rawQuery("Select * from task")).cast<Map>();
  print("length of string:");
  print(list.length);
  List<Map> temp;
  if (list == null) {
    return null;
  }
  else{
    temp=list;
  }
   if (0 < temp.length) {
      return list;
    }
    return null;
  }

// Future<int> deleteItem(int id) async {
//   return await _databaseHelper.db
//       .delete("travel", where: "serial_number = ?", whereArgs: [id]);
// }

// Future<int> deleteTravelbyTrip(int id) async {
//   return await _databaseHelper.db.delete("travel", where: "tripid = ?", whereArgs: [id]);
// }
//
// Future<int> updateTravelExpense(
//     int id,
//     int tripid,
//     String dep_time,
//     String dep_date,
//     String dep_station,
//     String arr_time,
//     String arr_date,
//     String arr_station,
//     String mot,
//     double km,
//     double fare,
//     String currency,
//     String pnr,
//     String remarks,
//     String ticket_address,
//     String receipt_location) async {
//   final todo = new Travel(
//     tripid: tripid,
//     dep_time: dep_time,
//     dep_date: dep_date,
//     dep_station: dep_station,
//     arr_time: arr_time,
//     arr_date: arr_date,
//     arr_station: arr_station,
//     mot: mot,
//     km: km,
//     fare: fare,
//     currency: currency,
//     pnr: pnr,
//     remarks: remarks,
//     ticket_address: ticket_address,
//     receipt_location: receipt_location,
//   );
//   return await _databaseHelper.db.update('travel', todo.toMap(),
//       where: "serial_number = ?", whereArgs: [id]);
// }
//
// Future<int> updateaddress(String add, int id) async {
//   //databaseHelper has been injected in the class
//   int sn = await _databaseHelper.db.rawUpdate(
//       '''UPDATE travel SET receipt_location = ? WHERE serial_number = ?''',
//       [add, id]);
//
//   return sn;
// }
//
// Future<List<Map>> GetTotal(
//     int id,
//     ) async {
//   List<Map> list = await _databaseHelper.db.rawQuery(
//       "SELECT sum(fare) as am, currency FROM travel WHERE tripid = ? GROUP BY currency",
//       [id]);
//   print(list);
//   if (list.length > 0) {
//     return list;
//   }
//   return null;
// }
//
