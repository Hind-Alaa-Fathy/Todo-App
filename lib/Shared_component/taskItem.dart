
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/cubit.dart';


Widget buildTaskItem(Map model,context) {
  bool isEditing = TodoCubit.get(context).isEditing(model["id"]);
  var titleController = TextEditingController();

 return Dismissible(
  key: Key(model["id"].toString()),
  child: Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      color: Colors.blueGrey,
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
        children: [
          //time
          isEditing ? GestureDetector(
            child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: Text("${model['time']}",style: TextStyle(fontSize: 16,color: Colors.blueGrey[800])),
                  ),
            onTap: (){
              showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now())
                  .then((value) {
                print(value?.format(context));
                TodoCubit.get(context).updateTime(time: value!.format(context).toString(), id: model["id"]);

              });
            },

          )
              : CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            child: Text("${model['time']}",style:  TextStyle(fontSize: 16,color: Colors.blueGrey[800])),
          ),
          const SizedBox(width: 10),
          //title & date
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //title
                isEditing? TextFormField(
                  decoration: InputDecoration(
                    hintText: "${model['title']}",
                    focusedBorder: InputBorder.none,
                  ),
                  cursorColor: Colors.green[900],
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  onTap: () {
                    titleController.text = model['title'];
                  },
                ): Text("${model['title']}",style: const TextStyle(fontSize: 18)),
                SizedBox(height: 10,),
                //date
                isEditing? GestureDetector(
                  child: Text("${model['date']}",style:  TextStyle(fontSize: 16,color: Colors.blueGrey[800])),
                  onTap: (){
                        showDatePicker(
                                context: context,
                               firstDate: DateTime.now(),
                               lastDate: DateTime.parse('2027-07-01'),
                              ).then((value) {
                            print(
                             DateFormat.yMMMd().format(value!));
                            TodoCubit.get(context).updateDate(date: DateFormat.yMMMd().format(value), id: model["id"]);
                          });
                 }

                ): Text("${model['date']}",style: TextStyle(fontSize: 15,color: Colors.blueGrey[800])),
              ],
            ),
          ),

          isEditing ? IconButton(onPressed: (){

            TodoCubit.get(context).stopEditing();

           if(titleController.text != "")
             {
               TodoCubit.get(context).updateTitle(title: titleController.text ?? model['title'], id: model["id"]);
             }

          },
            icon: Icon(Icons.edit_off_rounded,color: Colors.teal[900],size: 25,)):
          IconButton(onPressed: (){

          TodoCubit.get(context).startEditing(model["id"]);


            },
              icon: Icon(Icons.edit,color: Colors.teal[900],size: 30,)) ,
          IconButton(onPressed: (){
            TodoCubit.get(context).updateStatus(status: "done", id: model['id']);
          }, icon:  Icon(Icons.check_box,color: Colors.teal[900],size: 30,)),
          IconButton(onPressed: (){
            TodoCubit.get(context).updateStatus(status: "archive", id: model['id']);
          }, icon:  Icon(Icons.archive,color: Colors.brown[900],size: 30,)),
        ],
      ),
    ),
  ),
  onDismissed: (direction){
  TodoCubit.get(context).deleteData(id: model["id"]);
  },
);

}

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
        child: Divider(thickness: 1,color: Colors.blueGrey,),
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