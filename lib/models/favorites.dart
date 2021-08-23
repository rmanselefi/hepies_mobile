class Favorites {
  final int id;
  final int profession_id;
  final String drug_name;
  final String name;
  final String route;
  final String strength;
  final String unit;

  Favorites(
      {this.id,
      this.profession_id,
      this.drug_name,
      this.name,
      this.route,
      this.strength,
      this.unit});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profession_id': profession_id,
      'drug_name': drug_name,
      'route': route,
      'strength': strength,
      'unit': unit
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $strength}';
  }
}
