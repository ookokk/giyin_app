class Combination {
  Combination({
    this.id,
    this.selectedClothedUrls,
    this.createdDate,
    this.dateToWear,
  });
  DateTime? dateToWear;
  String? id;

  List<String>? selectedClothedUrls;
  DateTime? createdDate;
  void setDateToWear(DateTime newDateToWear) {
    dateToWear = newDateToWear;
  }

  void setId(String newId) {
    id = newId;
  }

  void addToSelectedClothes(String newClothe) {
    selectedClothedUrls!.add(newClothe);
  }

  void setCreatedDate(DateTime newCreatedDate) {
    createdDate = newCreatedDate;
  }
}
