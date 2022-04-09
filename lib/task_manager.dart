import 'package:remind/task.dart';

class task_manager{
  var arr = [];
  task_manager();
  void set_list(list){
    this.arr=list;
  }
  void update_list(task t){
    this.arr.add(t);
  }
}