class Chemistry {
  int id;
  String fbs;
  String rbs;
  String hba1c;
  String bunurea;
  String creatinine;
  String astsgot;
  String altsgpt;
  String alp;
  String albumin;
  String protein;
  String triglyceride;
  String cholesterol;
  String hdl;
  String ldl;
  String amylase;
  String lipase;
  String sodium;
  String potassium;
  String calcium;
  String calciumionized;
  String phosphorous;
  String chloride;
  String magnesium;
  String TIBC;
  String iron;
  String transferrinsaturation;
  String ferritin;
  String serumfolate;
  String bilirubintotal;
  String bilirubindirect;
  String bilirubinindirect;
  String totalprotein;
  Chemistry(
      {this.id,
      this.albumin,
      this.alp,
      this.altsgpt,
      this.amylase,
      this.astsgot,
      this.bunurea,
      this.calcium,
      this.totalprotein,
      this.calciumionized,
      this.bilirubindirect,
      this.bilirubinindirect,
      this.bilirubintotal,
      this.creatinine,
      this.chloride,
      this.cholesterol,
      this.fbs,
      this.ferritin,
      this.hba1c,
      this.hdl,
      this.iron,
      this.ldl,
      this.lipase,
      this.magnesium,
      this.phosphorous,
      this.potassium,
      this.protein,
      this.rbs,
      this.serumfolate,
      this.sodium,
      this.TIBC,
      this.transferrinsaturation,
      this.triglyceride});

  Map<String, dynamic> toJson() => {
        'id': id,
        'albumin': albumin,
        'alp': alp,
        'altsgpt': altsgpt,
        'amylase': amylase,
        'astsgot': astsgot,
        'bunurea': bunurea,
        'calcium': calcium,
        'totalprotein': totalprotein,
        'calciumionized': calciumionized,
        'bilirubindirect': bilirubindirect,
        'bilirubinindirect': bilirubinindirect,
        'bilirubintotal': bilirubintotal,
        'creatinine': creatinine,
        'chloride': chloride,
        'cholesterol': cholesterol,
        'fbs': fbs,
        'ferritin': ferritin,
        'hba1c': hba1c,
        'hdl': hdl,
        'iron': iron,
        'ldl': ldl,
        'lipase': lipase,
        'magnesium': magnesium,
        'phosphorous': phosphorous,
        'potassium': potassium,
        'protein': protein,
        'rbs': rbs,
        'serumfolate': serumfolate,
        'sodium': sodium,
        'TIBC': TIBC,
        'transferrinsaturation': transferrinsaturation,
        'triglyceride': triglyceride
      };
}
