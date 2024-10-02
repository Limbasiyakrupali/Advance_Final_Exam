class RecipesModel {
  int id;
  int quantity;
  String name;
  String type;

  RecipesModel(
      {required this.id,
      required this.quantity,
      required this.name,
      required this.type});

  factory RecipesModel.fromMap({required Map data}) {
    return RecipesModel(
        id: data['id'],
        quantity: data['quantity'],
        name: data['name'],
        type: data['type']);
  }
}
