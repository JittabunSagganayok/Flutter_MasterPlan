import 'package:flutter/material.dart';
import 'package:master_plan/plan_provider.dart';
import 'package:master_plan/views/plan_creator_page.dart';

void main() {
  runApp(PlanProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Plan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PlanCreatorPage(title: 'Master Plan'),
    );
  }
}
