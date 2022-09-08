class Favorites {
  final int id;
  final int profession_id;
  String drug_name;
  String name;
  final String route;
  final String strength;
  final String unit;
  final String type;
  final String takein;
  final String frequency;
  final int drug;
  final String ampule;
  final String material_name;
  final String size;
  final String amount;

  Favorites(
      {this.id,
      this.profession_id,
      this.drug_name,
      this.drug,
      this.name,
      this.route,
      this.strength,
      this.unit,
      this.type,
      this.frequency,
      this.takein,
      this.ampule,
      this.material_name,
      this.amount,
      this.size});

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profession_id': profession_id,
      'drug_name': drug_name,
      'drug': drug,
      'route': route,
      'strength': strength,
      'unit': unit,
      'type': type,
      'frequency': frequency,
      'takein': takein,
      'ampule': ampule,
      'material_name': material_name,
      'amount': amount,
      'size': size
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'name': name,
      'profession_id': profession_id,
      'drug_name': drug_name,
      'drug': drug,
      'route': route,
      'strength': strength,
      'unit': unit,
      'type': type,
      'frequency': frequency,
      'takein': takein,
      'ampule': ampule,
      'material_name': material_name,
      'amount': amount,
      'size': size
    };
  }
}
