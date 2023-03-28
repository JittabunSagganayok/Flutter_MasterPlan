import 'package:master_plan/models/plan.dart';
import 'package:master_plan/models/task.dart';
import 'package:master_plan/repositories/in_memory_cache.dart';
import 'package:master_plan/repositories/repository.dart';

class PlanService {
  final Repository _repository = InMemoryCache();

  Plan createNewPlan(String name) {
    final model = _repository.create();
    final plan = Plan.fromModel(model)..name = name;
    savePlan(plan);
    return plan;
  }

  void savePlan(Plan plan) {
    _repository.update(plan.toModel());
  }

  void deletePlan(Plan plan) {
    _repository.delete(plan.toModel());
  }

  List<Plan> getAllPlans() {
    return _repository.getAll().map((e) => Plan.fromModel(e)).toList();
  }

  void addTask(Plan plan, String description) {
    final id = (plan.tasks.isEmpty ? 0 : plan.tasks.last.id) + 1;
    final task = Task(id: id, description: description);
    plan.tasks.add(task);
    savePlan(plan);
  }

  deleteTask(Plan plan, Task task) {
    plan.tasks.remove(task);
    savePlan(plan);
  }
}
