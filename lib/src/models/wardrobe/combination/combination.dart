class Combination {
  Combination({
    this.id,
    this.name,
    this.selectedClothes,
    this.createdDate,
  });

  String? id;
  String? name;
  List<String>? selectedClothes;
  DateTime? createdDate;

  set setId(String newId) {
    id = newId;
  }

  set setName(String newName) {
    name = newName;
  }

  set addToSelectedClothes(String newClothe) {
    selectedClothes!.add(newClothe);
  }

  set setCreatedDate(DateTime newCreatedDate) {
    createdDate = newCreatedDate;
  }
}
