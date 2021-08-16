class Urine {
  int id;
  String urinehcg;
  String stoolexam;
  String stooloccultblood;
  String stoolplylori;
  Urine(
      {this.id,
      this.stoolexam,
      this.stooloccultblood,
      this.stoolplylori,
      this.urinehcg});

  Map<String, dynamic> toJson() => {
        'id': id,
        'stoolexam': stoolexam,
        'stooloccultblood': stooloccultblood,
        'urinehcg': urinehcg,
        'stoolplylori': stoolplylori,
      };
}
