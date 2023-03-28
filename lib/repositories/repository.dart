abstract class Repository {
  Model create();
  Model get(int id);
  List<Model> getAll();
  void update(Model item);
  void delete(Model item);
  void clear();
}

class Model {
  final int id;
  final Map data;

  Model({required this.id, this.data = const {}});
}
