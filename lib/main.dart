import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'Shared_component/bloc_observer.dart';
import 'layout/home_layout.dart';

void main() {
  Bloc.observer = const TodoBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
