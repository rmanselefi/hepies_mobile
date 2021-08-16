class Endocrinology {
  int id;
  String t3;
  String t4;
  String pth;
  String tsh;
  String fsh;
  String lh;
  String progesterone;
  String estradiol;
  String testosterone;
  String prolactin;
  String serumcortisol;
  String serumcalcitonin;
  String erythropoietin;
  String growthhormone;
  String vitb12;
  String vitD;
  Endocrinology(
      {this.id,
      this.erythropoietin,
      this.estradiol,
      this.fsh,
      this.growthhormone,
      this.lh,
      this.progesterone,
      this.prolactin,
      this.pth,
      this.serumcalcitonin,
      this.serumcortisol,
      this.t3,
      this.t4,
      this.testosterone,
      this.tsh,
      this.vitb12,
      this.vitD});
  Map<String, dynamic> toJson() => {
        'id': id,
        'erythropoietin': erythropoietin,
        'estradiol': estradiol,
        'fsh': fsh,
        'growthhormone': growthhormone,
        'lh': lh,
        'progesterone': progesterone,
        'prolactin': prolactin,
        'pth': pth,
        'serumcalcitonin': serumcalcitonin,
        'serumcortisol': serumcortisol,
        't3': t3,
        't4': t4,
        'testosterone': testosterone,
        'tsh': tsh,
        'vitb12': vitb12,
        'vitD': vitD
      };
}
