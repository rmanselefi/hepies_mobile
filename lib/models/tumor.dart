class Tumor {
  int id;
  String tpsa;
  String afp;
  String cea;
  String ca125;
  String ca19;
  Tumor({this.id, this.afp, this.ca19, this.ca125, this.cea, this.tpsa});

  Map<String, dynamic> toJson() => {
        'id': id,
        'afp': afp,
        'ca19': ca19,
        'ca125': ca125,
        'cea': cea,
        'tpsa': tpsa
      };
}
