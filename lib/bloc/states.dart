abstract class TodoStates {}

 class TodoInitialState extends TodoStates {}

 class TodoBottomNavBarState extends TodoStates {}

 class TodoIconState extends TodoStates {}

 class TodoCreateDatabaseState extends TodoStates {}
 class TodoInsertDatabaseState extends TodoStates {}
 class TodoGetDatabaseState extends TodoStates {}
 class TodoDeleteDatabaseState extends TodoStates {}
 class TodoGetDatabaseLoadingState extends TodoStates {}

 class TodoUpdateTitleDatabaseState extends TodoStates {}
 class TodoUpdateDateDatabaseState extends TodoStates {}
 class TodoUpdateTimeDatabaseState extends TodoStates {}
 class TodoUpdateStatusDatabaseState extends TodoStates {}

 class TodoStartEditingState extends TodoStates {}
 class TodoStopEditingState extends TodoStates {}