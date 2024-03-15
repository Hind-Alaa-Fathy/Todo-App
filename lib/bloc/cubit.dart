import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/bloc/states.dart';
import '../screens/archived_screen.dart';
import '../screens/done_screen.dart';
import '../screens/tasks_screen.dart';

class TodoCubit extends Cubit<TodoStates>
{
  TodoCubit() : super (TodoInitialState());
 static TodoCubit get(context) => BlocProvider.of(context);

  List screens = [
    const NewTask(),
    const DoneScreen(),
    const ArchivedScreen(),
  ];
  List<String> texts = ["Tasks", "Done Tasks", "Archived Tasks"];

  int currentIndex = 0;
  void getCurrentIndex(int index)
  {
    currentIndex = index;
    emit(TodoBottomNavBarState());
  }
  IconData floatIcon = Icons.edit;
  bool isBottomSheetShown = false;
  void iconBottomSheetChange(IconData icon, bool bottomSheetShown)
  {
    floatIcon = icon;
    isBottomSheetShown = bottomSheetShown;
    emit(TodoIconState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase()  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        print("database created");
        db.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT, time TEXT, status TEXT)').then((value) {
          print("table created");
        }).catchError((error) {
          print("Error when creating table ${error.toString()}");
        });
      },
      onOpen: (db) {
        getDataFromDatabase(db);
        print("database opened");
      },
    ).then((value) {
      database = value;
      emit(TodoCreateDatabaseState());
    });
  }

   insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async
  {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","NEW")')
          .then((value) {
        print("$value inserted successfully");
        emit(TodoInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print("error when inserting new record ${error.toString()}");
      });
    });
  }

  void getDataFromDatabase(database)
  {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(TodoGetDatabaseLoadingState());
     database.rawQuery('SELECT * FROM tasks').then((value) {

       value.forEach((element) {
         if(element["status"] == 'NEW')
           {
             newTasks.add(element);
           }
         else if(element["status"] == 'archive')
         {
           archivedTasks.add(element);
         }
         else
         {
           doneTasks.add(element);
         }

       });
       emit(TodoGetDatabaseState());
     });
  }

  void updateStatus({
    required String status,
    required int id,
})async
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]).then((value) {
         getDataFromDatabase(database);
          emit(TodoUpdateStatusDatabaseState());

    });
  }

  bool isTaskEditing = false;
  int editingTaskId = 0;

  void startEditing(int id) {
    isTaskEditing = true;
    editingTaskId = id;
    emit(TodoStartEditingState());
  }

  void stopEditing() {
    isTaskEditing = false;
    editingTaskId = 0;
    emit(TodoStopEditingState());
  }

  bool isEditing(int id) {
    return isTaskEditing && editingTaskId == id;
  }
  void updateTitle({
     required String title,
    required int id,
  })async
  {
    database.rawUpdate(
        'UPDATE tasks SET title = ? WHERE id = ?',
        [title,id]).then((value) {
      getDataFromDatabase(database);
      emit(TodoUpdateTitleDatabaseState());

    });
  }  void updateDate({
     required String date,
    required int id,
  })async
  {
    database.rawUpdate(
        'UPDATE tasks SET date = ? WHERE id = ?',
        [date, id]).then((value) {
      getDataFromDatabase(database);
      emit(TodoUpdateDateDatabaseState());

    });
  }  void updateTime({
     required String time,
    required int id,
  })async
  {
    database.rawUpdate(
        'UPDATE tasks SET time = ? WHERE id = ?',
        [time, id]).then((value) {
      getDataFromDatabase(database);
      emit(TodoUpdateTimeDatabaseState());

    });
  }

  void deleteData({
    required int id,
  })async
  {
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(TodoDeleteDatabaseState());

    });
  }

}