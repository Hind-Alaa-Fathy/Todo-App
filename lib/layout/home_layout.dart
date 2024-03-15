import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/cubit.dart';
import 'package:todo_app/bloc/states.dart';
import '../Shared_component/default_textformfield.dart';


class HomeLayout extends StatelessWidget {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context) => TodoCubit()..createDatabase(),
        child: BlocConsumer<TodoCubit,TodoStates>(
            listener: (context, state) {
              if(state is TodoInsertDatabaseState)
                {
                  Navigator.pop(context);
                }
            } ,
            builder: (context, state) {
              TodoCubit cubit = TodoCubit.get(context);
              return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[600],
              title: Text(cubit.texts[cubit.currentIndex]),

            ),
            backgroundColor: Colors.cyan[900],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.blueGrey[600],
              currentIndex: TodoCubit.get(context).currentIndex,
              selectedItemColor: Colors.blueGrey[400],
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks",),
                BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: "Archived"),
              ],

              onTap: (value) {
                cubit.getCurrentIndex(value);
              },
            ),
            body: state is! TodoGetDatabaseLoadingState ? cubit.screens[cubit.currentIndex] : const CircularProgressIndicator(color:Colors.orange),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              backgroundColor: Colors.blueGrey[600],
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {

                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                    );

                    titleController.clear();
                    timeController.clear();
                    dateController.clear();
                    cubit.iconBottomSheetChange(Icons.edit,false);
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                          (context) =>
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            color: Colors.blueGrey[400],
                            child: SingleChildScrollView(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DefaultTextFormField(
                                      hintText: "Title",
                                      keyboardType: TextInputType.text,
                                      prefixIcon: Icons.title,
                                      controller: titleController,
                                      validationText: "title",
                                      onTap: () {},
                                    ),
                                    DefaultTextFormField(
                                      hintText: "time",
                                      keyboardType: TextInputType.datetime,
                                      prefixIcon: Icons.watch,
                                      controller: timeController,
                                      validationText: "time",
                                      onTap: () {
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                            .then((value) {
                                          print(value?.format(context));
                                          timeController.text =
                                              value!.format(context).toString();
                                        });
                                      },
                                    ),
                                    DefaultTextFormField(
                                      hintText: "date",
                                      keyboardType: TextInputType.datetime,
                                      prefixIcon: Icons.calendar_month_outlined,
                                      controller: dateController,
                                      validationText: "date",
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2027-07-01'),
                                        ).then((value) {
                                          print(
                                              DateFormat.yMMMd().format(value!));
                                          dateController.text =
                                              DateFormat.yMMMd().format(value);
                                        });
                                        print("date");
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      backgroundColor: Colors.grey[300])
                      .closed
                      .then((value) {
                    titleController.clear();
                    timeController.clear();
                    dateController.clear();
                    cubit.iconBottomSheetChange(Icons.edit,false);
                  });
                  cubit.iconBottomSheetChange(Icons.add,true);
                }
              },
              child: Icon(
                TodoCubit.get(context).floatIcon,
                color: Colors.blueGrey[900],
                size: 35,
              ),
            ),
          );},
        ),
    );
  }
}