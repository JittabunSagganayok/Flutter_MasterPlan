import 'package:flutter/material.dart';
import 'package:master_plan/models/data_layer.dart';
import 'package:master_plan/plan_provider.dart';

class PlanPage extends StatefulWidget {
  final Plan plan;

  const PlanPage({super.key, required this.plan});

  @override
  State<StatefulWidget> createState() {
    return _PlanPageState();
  }
}

class _PlanPageState extends State<PlanPage> {
  Plan get plan => widget.plan;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final controller = PlanProvider.of(context);
        controller.savePlan(plan);
        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(plan.name),
          ),
          body: Column(
            children: [
              Expanded(child: _buildList()),
              SafeArea(child: Text(plan.completenessMessage)),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                plan.tasks.add(Task(id: plan.tasks.length + 1));
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) {
        final task = plan.tasks[index];
        return ListTile(
          leading: Checkbox(
            value: task.complete,
            onChanged: (value) {
              setState(() {
                task.complete = value!;
              });
            },
          ),
          title: TextFormField(
            initialValue: task.description,
            onChanged: (value) {
              setState(() {
                task.description = value;
              });
            },
          ),
        );
      },
    );
  }
}
