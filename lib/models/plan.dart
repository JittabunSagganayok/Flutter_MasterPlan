import 'package:master_plan/models/task.dart';
import 'package:master_plan/repositories/repository.dart';

class Plan {
  final int id;
  String name = '';
  List<Task> tasks = [];

  Plan({required this.id, this.name = ''});

  Plan.fromModel(Model model)
      : id = model.id,
        name = model.data.containsKey('name') ? model.data['name'] : '',
        tasks = model.data.containsKey('tasks')
            ? model.data['tasks']
                    .map<Task>((task) => Task.fromModel(task))
                    .toList() ??
                <Task>[]
            : <Task>[];

  Model toModel() {
    return Model(
        id: id,
        data: {'name': name, 'tasks': tasks.map((e) => e.toModel()).toList()});
  }

  int get completeCount => tasks.where((element) => element.complete).length;

  String get completenessMessage =>
      '$completeCount out of ${tasks.length} tasks';
}
