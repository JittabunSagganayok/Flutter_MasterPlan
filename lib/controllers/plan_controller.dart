import 'package:master_plan/models/plan.dart';
import 'package:master_plan/models/task.dart';
import 'package:master_plan/services/plan_service.dart';

class PlanController {
  final _service = PlanService();

  List<Plan> get plans => List.unmodifiable(_service.getAllPlans());

  String _checkForDuplicates(Iterable<String> items, String text) {
    final duplicatedCount =
        items.where((element) => element.contains(text)).length;
    if (duplicatedCount > 0) {
      text += ' ${duplicatedCount + 1}';
    }
    return text;
  }

  void addNewPlan(String name) {
    if (name.isEmpty) {
      return;
    }
    name = _checkForDuplicates(plans.map((e) => e.name), name);
    _service.createNewPlan(name);
  }

  void deletePlan(Plan plan) {
    _service.deletePlan(plan);
  }

  void savePlan(Plan plan) {
    _service.savePlan(plan);
  }

  void createNewTask(Plan plan, [String? description]) {
    if (description == null || description.isEmpty) {
      description = 'New Task';
    }
    description =
        _checkForDuplicates(plan.tasks.map((e) => e.description), description);
    _service.addTask(plan, description);
  }

  void deleteTask(Plan plan, Task task) {
    _service.deleteTask(plan, task);
  }
}
