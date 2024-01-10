
import 'package:flutter/material.dart';
import 'package:todo_app/bloc/cubit.dart';

Widget buildTaskItem(Map model,context)=> Dismissible(
  key: Key(model["id"].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      color: Colors.blueGrey,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
           CircleAvatar(
            radius: 45,
            backgroundColor: Colors.grey,
            child: Text("${model['time']}",style:  TextStyle(fontSize: 20,color: Colors.blueGrey[800])),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text("${model['title']}",style: const TextStyle(fontSize: 25)),
                Text("${model['date']}",style: TextStyle(fontSize: 20,color: Colors.blueGrey[800])),
              ],
            ),
          ),
          const SizedBox(width: 15),
          IconButton(onPressed: (){
            TodoCubit.get(context).updateData(status: "done", id: model['id']);
          }, icon:  Icon(Icons.check_box,color: Colors.teal[900],size: 30,)),
          IconButton(onPressed: (){
            TodoCubit.get(context).updateData(status: "archive", id: model['id']);
          }, icon:  Icon(Icons.archive,color: Colors.brown[900],size: 30,)),
        ],
      ),
    ),
  ),
  onDismissed: (direction){
  TodoCubit.get(context).deleteData(id: model["id"]);
  },
);

Widget tasksBuilder({
  required List<Map> tasks,
  required IconData iconIsEmpty,
  required String textIsEmpty,
})
{
  return tasks.isNotEmpty ? ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index],context),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(left: 25,right: 10),
        child: Divider(thickness: 2),
      ),
      itemCount: tasks.length) :  Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconIsEmpty,size: 70,color: Colors.black45),
          const SizedBox(height: 30,),
          Text(textIsEmpty,style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 20,color: Colors.black45)),
        ],
      ),
    ),
  );
}