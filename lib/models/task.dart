import 'package:master_plan/repositories/repository.dart';

class Task {
  final int id;
  bool complete;
  String description;

  Task({required this.id, this.complete = false, this.description = ''});

  Task.fromModel(Model model)
      : id = model.id,
        description = model.data.containsKey('description')
            ? model.data['description']
            : '',
        complete =
            model.data.containsKey('complete') ? model.data['complete'] : false;

  Model toModel() {
    return Model(
        id: id, data: {'description': description, 'complete': complete});
  }
}
