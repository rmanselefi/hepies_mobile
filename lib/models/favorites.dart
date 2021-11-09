class Favorites {
  final int id;
  final int profession_id;
  final String drug_name;
  final String name;
  final String route;
  final String strength;
  final String unit;
  final String type;
  final String takein;
  final String frequency;
  final int drug;

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
      this.takein});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profession_id': profession_id,
      'drug_name': drug_name,
      'drug':drug,
      'route': route,
      'strength': strength,
      'unit': unit,
      'type': type,
      'frequency': frequency,
      'takein': takein
    };
  }
}
