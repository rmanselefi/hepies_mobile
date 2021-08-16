class Serology {
  int id;
  String widal;
  String welfelix;
  String aso;
  String rf;
  String crp;
  String ana;
  String betahcg;
  String coombs;
  String hbsag;
  String hivmedical;
  String hivviralload;
  String cd4count;
  Serology(
      {this.id,
      this.ana,
      this.cd4count,
      this.hbsag,
      this.aso,
      this.betahcg,
      this.coombs,
      this.crp,
      this.hivmedical,
      this.hivviralload,
      this.rf,
      this.welfelix,
      this.widal});

  Map<String, dynamic> toJson() => {
        'id': id,
        'ana': ana,
        'cd4count': cd4count,
        'hbsag': hbsag,
        'aso': aso,
        'betahcg': betahcg,
        'coombs': coombs,
        'crp': crp,
        'hivmedical': hivmedical,
        'hivviralload': hivviralload,
        'rf': rf,
        'welfelix': welfelix,
        'widal': widal
      };
}
