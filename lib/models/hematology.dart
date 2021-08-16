class Hematology {
  int id;
  String wbccount;
  String hgb;
  String hct;
  String mcv;
  String mch;
  String mchc;
  String pltcount;
  String reticulocyte;
  String bgrh;
  String esr;

  Hematology(
      {this.id,
      this.bgrh,
      this.hgb,
      this.esr,
      this.hct,
      this.mch,
      this.mchc,
      this.mcv,
      this.pltcount,
      this.reticulocyte,
      this.wbccount});

  Map<String, dynamic> toJson() => {
        'id': id,
        'bgrh': bgrh,
        'hgb': hgb,
        'esr': esr,
        'hct': hct,
        'mch': mch,
        'mchc': mchc,
        'mcv': mcv,
        'pltcount': pltcount,
        'reticulocyte': reticulocyte,
        'wbccount': wbccount
      };
}
