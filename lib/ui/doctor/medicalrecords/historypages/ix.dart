import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hepies/models/chemistry.dart';
import 'package:hepies/models/endocrinology.dart';
import 'package:hepies/models/hematology.dart';
import 'package:hepies/models/investigation.dart';
import 'package:hepies/models/serology.dart';
import 'package:hepies/models/tumor.dart';
import 'package:hepies/models/urine.dart';
import 'package:hepies/ui/doctor/medicalrecords/historypages/collapse.dart';

class IX extends StatefulWidget {
  final Function setChemistry;
  final Function setEndocrinology;
  final Function setHematology;
  final Function setSerology;
  final Function setUrine;
  final Function setTumor;
  final Function setInvestigation;
  IX(
      {this.setChemistry,
      this.setEndocrinology,
      this.setHematology,
      this.setSerology,
      this.setUrine,
      this.setTumor,
      this.setInvestigation});
  @override
  _IXState createState() => _IXState();
}

class _IXState extends State<IX> with AutomaticKeepAliveClientMixin {
  bool isExpanded = false;
  var hematology = new Hematology();
  var serology = new Serology();
  var chemistry = new Chemistry();
  var endocrinology = new Endocrinology();
  var urine = new Urine();
  var ix = new Investigation();
  var tumor = new Tumor();

  //Hematology
  TextEditingController _wbccountController;
  TextEditingController _hgbController;
  TextEditingController _hctController;
  TextEditingController _mcvController;
  TextEditingController _mchController;
  TextEditingController _mchcController;
  TextEditingController _pltcountController;
  TextEditingController _reticulocyteController;
  TextEditingController _bgrhController;
  TextEditingController _esrController;

  //Chemistry
  TextEditingController fbs;
  TextEditingController rbs;
  TextEditingController hba1c;
  TextEditingController bunurea;
  TextEditingController creatinine;
  TextEditingController astsgot;
  TextEditingController altsgpt;
  TextEditingController alp;
  TextEditingController albumin;
  TextEditingController protein;
  TextEditingController triglyceride;
  TextEditingController cholesterol;
  TextEditingController hdl;
  TextEditingController ldl;
  TextEditingController amylase;
  TextEditingController lipase;
  TextEditingController sodium;
  TextEditingController potassium;
  TextEditingController calcium;
  TextEditingController calciumionized;
  TextEditingController phosphorous;
  TextEditingController chloride;
  TextEditingController magnesium;
  TextEditingController TIBC;
  TextEditingController iron;
  TextEditingController transferrinsaturation;
  TextEditingController ferritin;
  TextEditingController serumfolate;
  TextEditingController bilirubintotal;
  TextEditingController bilirubindirect;
  TextEditingController bilirubinindirect;
  TextEditingController totalprotein;

  //Urine
  TextEditingController urinehcg;
  TextEditingController stoolexam;
  TextEditingController stooloccultblood;
  TextEditingController stoolplylori;

  //Serology
  TextEditingController widal;
  TextEditingController welfelix;
  TextEditingController aso;
  TextEditingController rf;
  TextEditingController crp;
  TextEditingController ana;
  TextEditingController betahcg;
  TextEditingController coombs;
  TextEditingController hbsag;
  TextEditingController hivmedical;
  TextEditingController hivviralload;
  TextEditingController cd4count;

  //Tumor
  TextEditingController tpsa;
  TextEditingController afp;
  TextEditingController cea;
  TextEditingController ca125;
  TextEditingController ca19;

  //Endocrinology
  TextEditingController t3;
  TextEditingController t4;
  TextEditingController pth;
  TextEditingController tsh;
  TextEditingController fsh;
  TextEditingController lh;
  TextEditingController progesterone;
  TextEditingController estradiol;
  TextEditingController testosterone;
  TextEditingController prolactin;
  TextEditingController serumcortisol;
  TextEditingController serumcalcitonin;
  TextEditingController erythropoietin;
  TextEditingController growthhormone;
  TextEditingController vitb12;
  TextEditingController vitD;

  //Investigation
  TextEditingController _pathologyController;
  TextEditingController _microbiologyController;
  TextEditingController _radiologyController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Investigation
    _pathologyController = new TextEditingController();
    _microbiologyController = new TextEditingController();
    _radiologyController = new TextEditingController();

    //Endocrinology
    t3 = new TextEditingController();
    t4 = new TextEditingController();
    pth = new TextEditingController();
    tsh = new TextEditingController();
    fsh = new TextEditingController();
    lh = new TextEditingController();
    progesterone = new TextEditingController();
    estradiol = new TextEditingController();
    testosterone = new TextEditingController();
    prolactin = new TextEditingController();
    serumcortisol = new TextEditingController();
    serumcalcitonin = new TextEditingController();
    erythropoietin = new TextEditingController();
    growthhormone = new TextEditingController();
    vitb12 = new TextEditingController();
    vitD = new TextEditingController();

    //Tumor
    tpsa = new TextEditingController();
    afp = new TextEditingController();
    cea = new TextEditingController();
    ca125 = new TextEditingController();
    ca19 = new TextEditingController();

    //Serology
    widal = new TextEditingController();
    welfelix = new TextEditingController();
    aso = new TextEditingController();
    rf = new TextEditingController();
    crp = new TextEditingController();
    ana = new TextEditingController();
    betahcg = new TextEditingController();
    coombs = new TextEditingController();
    hbsag = new TextEditingController();
    hivmedical = new TextEditingController();
    hivviralload = new TextEditingController();
    cd4count = new TextEditingController();

    //Hematology
    _wbccountController = new TextEditingController();
    _hgbController = new TextEditingController();
    _hctController = new TextEditingController();
    _mcvController = new TextEditingController();
    _mchController = new TextEditingController();
    _mchcController = new TextEditingController();
    _pltcountController = new TextEditingController();
    _reticulocyteController = new TextEditingController();
    _bgrhController = new TextEditingController();
    _esrController = new TextEditingController();

    //Chemistry
    fbs = new TextEditingController();
    rbs = new TextEditingController();
    hba1c = new TextEditingController();
    bunurea = new TextEditingController();
    creatinine = new TextEditingController();
    astsgot = new TextEditingController();
    altsgpt = new TextEditingController();
    alp = new TextEditingController();
    albumin = new TextEditingController();
    protein = new TextEditingController();
    triglyceride = new TextEditingController();
    cholesterol = new TextEditingController();
    hdl = new TextEditingController();
    ldl = new TextEditingController();
    amylase = new TextEditingController();
    lipase = new TextEditingController();
    sodium = new TextEditingController();
    potassium = new TextEditingController();
    calcium = new TextEditingController();
    calciumionized = new TextEditingController();
    phosphorous = new TextEditingController();
    chloride = new TextEditingController();
    magnesium = new TextEditingController();
    TIBC = new TextEditingController();
    iron = new TextEditingController();
    transferrinsaturation = new TextEditingController();
    ferritin = new TextEditingController();
    serumfolate = new TextEditingController();
    bilirubintotal = new TextEditingController();
    bilirubindirect = new TextEditingController();
    bilirubinindirect = new TextEditingController();
    totalprotein = new TextEditingController();

    //Urine
    urinehcg = new TextEditingController();
    stoolexam = new TextEditingController();
    stooloccultblood = new TextEditingController();
    stoolplylori = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExpandableTheme(
      data: const ExpandableThemeData(
        iconColor: Colors.blue,
        useInkWell: true,
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        addAutomaticKeepAlives: true,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Input Results',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ExpandableNotifier(
              key: PageStorageKey('hematology'),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    ScrollOnExpand(
                      key: PageStorageKey('hematology'),
                      scrollOnExpand: true,
                      scrollOnCollapse: false,
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.redAccent, width: 3)),
                        child: ExpandablePanel(
                          collapsed: Text('Tap to see more'),
                          theme: const ExpandableThemeData(
                            headerAlignment:
                                ExpandablePanelHeaderAlignment.center,
                            tapBodyToCollapse: true,
                          ),
                          header: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Hematology",
                                style: Theme.of(context).textTheme.body2,
                              )),
                          expanded: _buildHemtologyForm(),
                          builder: (_, collapsed, expanded) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Expandable(
                                collapsed: collapsed,
                                expanded: expanded,
                                theme: const ExpandableThemeData(
                                    crossFadePoint: 0),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          ExpandableNotifier(
              key: PageStorageKey('chemistry'),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    ScrollOnExpand(
                      key: PageStorageKey('chemistry'),
                      scrollOnExpand: true,
                      scrollOnCollapse: false,
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xff0be9e2), width: 3)),
                        child: ExpandablePanel(
                          collapsed: Text('Tap to see more'),
                          theme: const ExpandableThemeData(
                            headerAlignment:
                                ExpandablePanelHeaderAlignment.center,
                            tapBodyToCollapse: true,
                          ),
                          header: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Chemistry",
                                style: Theme.of(context).textTheme.body2,
                              )),
                          expanded: _buildChemistryForm(),
                          builder: (_, collapsed, expanded) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Expandable(
                                collapsed: collapsed,
                                expanded: expanded,
                                theme: const ExpandableThemeData(
                                    crossFadePoint: 0),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          ExpandableNotifier(
              child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffeeee14), width: 3)),
                    child: ExpandablePanel(
                      collapsed: Text('Tap to see more'),
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Urine Analysis",
                            style: Theme.of(context).textTheme.body2,
                          )),
                      expanded: _buildUrineForm(),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
          ExpandableNotifier(
              child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffaf5050), width: 3)),
                    child: ExpandablePanel(
                      collapsed: Text('Tap to see more'),
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Stool Exam",
                            style: Theme.of(context).textTheme.body2,
                          )),
                      expanded: _buildStoolForm(),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
          ExpandableNotifier(
              child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffe9143f), width: 3)),
                    child: ExpandablePanel(
                      collapsed: Text('Tap to see more'),
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Serology",
                            style: Theme.of(context).textTheme.body2,
                          )),
                      expanded: _buildSerologyForm(),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
          ExpandableNotifier(
              child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xfff35ad9), width: 3)),
                    child: ExpandablePanel(
                      collapsed: Text('Tap to see more'),
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Endocrinology",
                            style: Theme.of(context).textTheme.body2,
                          )),
                      expanded: _buildEndocrinologyForm(),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
          ExpandableNotifier(
              child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff2f28e7), width: 3)),
                    child: ExpandablePanel(
                      collapsed: Text('Tap to see more'),
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Tumor Markers",
                            style: Theme.of(context).textTheme.body2,
                          )),
                      expanded: _buildTumorForm(),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
          ExpandableNotifier(
              child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff000000), width: 3)),
                    child: ExpandablePanel(
                      collapsed: Text('Tap to see more'),
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Microbiology Index",
                            style: Theme.of(context).textTheme.body2,
                          )),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            onChanged: (val) {
                              ix.microbiology = val;
                              print("object ${ix.microbiology}");
                              widget.setInvestigation(ix);
                            },
                            decoration: InputDecoration(
                                hintText: 'Microbiology Index',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black45, width: 2))),
                            controller: _microbiologyController,
                          ),
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
          ExpandableNotifier(
              child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff000000), width: 3)),
                    child: ExpandablePanel(
                      collapsed: Text('Tap to see more'),
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Pathology Index",
                            style: Theme.of(context).textTheme.body2,
                          )),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            onChanged: (val) {
                              ix.pathologyindex = val;
                              print("object ${ix.pathologyindex}");
                              widget.setInvestigation(ix);
                            },
                            decoration: InputDecoration(
                                hintText: 'Pathology Index',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black45, width: 2))),
                            controller: _pathologyController,
                          )
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
          ExpandableNotifier(
              child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff000000), width: 3)),
                    child: ExpandablePanel(
                      collapsed: Text('Tap to see more'),
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Radiology Index",
                            style: Theme.of(context).textTheme.body2,
                          )),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            onChanged: (val) {
                              ix.radiologyindex = val;
                              print("object ${ix.radiologyindex}");
                              widget.setInvestigation(ix);
                            },
                            decoration: InputDecoration(
                                hintText: 'Radiology Index',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black45, width: 2))),
                            controller: _radiologyController,
                          )
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildHemtologyForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: _wbccountController,
          onChanged: (val) {
            hematology.wbccount = val;
            print("object ${hematology.wbccount}");
            widget.setHematology(hematology);
          },
          decoration: InputDecoration(
              hintText: 'WBC Count',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: _hgbController,
            onChanged: (val) {
              hematology.hgb = val;
              print("object ${hematology.hgb}");
              widget.setHematology(hematology);
            },
            decoration: InputDecoration(
                hintText: 'Hgb',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: _hctController,
          onChanged: (val) {
            hematology.hct = val;
            print("object ${hematology.hct}");
            widget.setHematology(hematology);
          },
          decoration: InputDecoration(
              hintText: 'HCT',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: _mcvController,
            onChanged: (val) {
              hematology.mcv = val;
              print("object ${hematology.mcv}");
              widget.setHematology(hematology);
            },
            decoration: InputDecoration(
                hintText: 'MCV',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: _mchController,
          onChanged: (val) {
            hematology.mch = val;
            print("object ${hematology.mch}");
            widget.setHematology(hematology);
          },
          decoration: InputDecoration(
              hintText: 'MCH',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: _mchcController,
            onChanged: (val) {
              hematology.mchc = val;
              print("object ${hematology.mchc}");
              widget.setHematology(hematology);
            },
            decoration: InputDecoration(
                hintText: 'MCHC',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: _pltcountController,
          onChanged: (val) {
            hematology.pltcount = val;
            print("object ${hematology.pltcount}");
            widget.setHematology(hematology);
          },
          decoration: InputDecoration(
              hintText: 'Plt count',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: _reticulocyteController,
            onChanged: (val) {
              hematology.reticulocyte = val;
              print("object ${hematology.reticulocyte}");
              widget.setHematology(hematology);
            },
            decoration: InputDecoration(
                hintText: 'Reticulocyte',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: _bgrhController,
          onChanged: (val) {
            hematology.bgrh = val;
            print("object ${hematology.bgrh}");
            widget.setHematology(hematology);
          },
          decoration: InputDecoration(
              hintText: 'BG and RHE',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: _esrController,
          onChanged: (val) {
            hematology.esr = val;
            print("object ${hematology.esr}");
            widget.setHematology(hematology);
          },
          decoration: InputDecoration(
              hintText: 'ESR',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
      ],
    );
  }

  Widget _buildChemistryForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: fbs,
          onChanged: (val) {
            chemistry.fbs = val;
            print("object ${chemistry.fbs}");
            widget.setChemistry(chemistry);
          },
          decoration: InputDecoration(
              hintText: 'FBS',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: rbs,
            onChanged: (val) {
              chemistry.rbs = val;
              print("object ${chemistry.rbs}");
              widget.setChemistry(chemistry);
            },
            decoration: InputDecoration(
                hintText: 'RBS',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: hba1c,
          onChanged: (val) {
            chemistry.hba1c = val;
            print("object ${chemistry.hba1c}");
            widget.setChemistry(chemistry);
          },
          decoration: InputDecoration(
              hintText: 'HbA1c',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: bunurea,
            onChanged: (val) {
              chemistry.bunurea = val;
              print("object ${chemistry.bunurea}");
              widget.setChemistry(chemistry);
            },
            decoration: InputDecoration(
                hintText: 'BUN/ure',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: creatinine,
          onChanged: (val) {
            chemistry.creatinine = val;
            print("object ${chemistry.creatinine}");
            widget.setChemistry(chemistry);
          },
          decoration: InputDecoration(
              hintText: 'Creatinine',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: astsgot,
            onChanged: (val) {
              chemistry.astsgot = val;
              print("object ${chemistry.astsgot}");
              widget.setChemistry(chemistry);
            },
            decoration: InputDecoration(
                hintText: 'AST/SGOT',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: altsgpt,
          onChanged: (val) {
            chemistry.altsgpt = val;
            print("object ${chemistry.altsgpt}");
            widget.setChemistry(chemistry);
          },
          decoration: InputDecoration(
              hintText: 'ALT/SGP',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: alp,
            onChanged: (val) {
              chemistry.alp = val;
              print("object ${chemistry.alp}");
              widget.setChemistry(chemistry);
            },
            decoration: InputDecoration(
                hintText: 'ALP',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: bilirubintotal,
          onChanged: (val) {
            chemistry.bilirubintotal = val;
            print("object ${chemistry.bilirubintotal}");
            widget.setChemistry(chemistry);
          },
          decoration: InputDecoration(
              hintText: 'Bilirubin Total',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: bilirubindirect,
          onChanged: (val) {
            chemistry.bilirubindirect = val;
            print("object ${chemistry.bilirubindirect}");
            widget.setChemistry(chemistry);
          },
          decoration: InputDecoration(
              hintText: 'Bilirubin Direct',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: bilirubinindirect,
            onChanged: (val) {
              chemistry.bilirubinindirect = val;
              print("object ${chemistry.bilirubinindirect}");
              widget.setChemistry(chemistry);
            },
            decoration: InputDecoration(
                hintText: 'Bilirubin Indirect',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: albumin,
          onChanged: (val) {
            chemistry.albumin = val;
            print("object ${chemistry.albumin}");
            widget.setChemistry(chemistry);
          },
          decoration: InputDecoration(
              hintText: 'Albumin',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: totalprotein,
            onChanged: (val) {
              chemistry.totalprotein = val;
              print("object ${chemistry.totalprotein}");
              widget.setChemistry(chemistry);
            },
            decoration: InputDecoration(
                hintText: 'Total Protein',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: triglyceride,
          onChanged: (val) {
            chemistry.triglyceride = val;
            print("object ${chemistry.triglyceride}");
            widget.setChemistry(chemistry);
          },
          decoration: InputDecoration(
              hintText: 'Triglyceride',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: cholesterol,
            onChanged: (val) {
              chemistry.cholesterol = val;
              print("object ${chemistry.cholesterol}");
              widget.setChemistry(chemistry);
            },
            decoration: InputDecoration(
                hintText: 'Cholesterol',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: hdl,
          onChanged: (val) {
            chemistry.hdl = val;
            print("object ${chemistry.hdl}");
            widget.setChemistry(chemistry);
          },
          decoration: InputDecoration(
              hintText: 'HDL',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: ldl,
            onChanged: (val) {
              chemistry.ldl = val;
              print("object ${chemistry.ldl}");
              widget.setChemistry(chemistry);
            },
            decoration: InputDecoration(
                hintText: 'LDL',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: amylase,
          onChanged: (val) {
            chemistry.amylase = val;
            print("object ${chemistry.amylase}");
            widget.setChemistry(chemistry);
          },
          decoration: InputDecoration(
              hintText: 'Amylase',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: lipase,
          onChanged: (val) {
            chemistry.lipase = val;
            print("object ${chemistry.lipase}");
            widget.setChemistry(chemistry);
          },
          decoration: InputDecoration(
              hintText: 'Lipase',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
      ],
    );
  }

  Widget _buildUrineForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: urinehcg,
          onChanged: (val) {
            urine.urinehcg = val;
            print("object ${urine.urinehcg}");
            widget.setUrine(urine);
          },
          decoration: InputDecoration(
              hintText: 'Urine HCG',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
      ],
    );
  }

  Widget _buildStoolForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: stoolexam,
          onChanged: (val) {
            urine.stoolexam = val;
            print("object ${urine.stoolexam}");
            widget.setUrine(urine);
          },
          decoration: InputDecoration(
              hintText: 'STOOL EXAM',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: stooloccultblood,
          onChanged: (val) {
            urine.stooloccultblood = val;
            print("object ${urine.stooloccultblood}");
            widget.setUrine(urine);
          },
          decoration: InputDecoration(
              hintText: 'STOOL OCCULT BLOOD',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
      ],
    );
  }

  Widget _buildSerologyForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: widal,
          onChanged: (val) {
            serology.widal = val;
            print("object ${serology.widal}");
            widget.setSerology(serology);
          },
          decoration: InputDecoration(
              hintText: 'Widal',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: welfelix,
            onChanged: (val) {
              serology.welfelix = val;
              print("object ${serology.welfelix}");
              widget.setSerology(serology);
            },
            decoration: InputDecoration(
                hintText: 'WelFelix',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: hbsag,
          onChanged: (val) {
            serology.hbsag = val;
            print("object ${serology.hbsag}");
            widget.setSerology(serology);
          },
          decoration: InputDecoration(
              hintText: 'HBsAg',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: hivmedical,
            onChanged: (val) {
              serology.hivmedical = val;
              print("object ${serology.hivmedical}");
              widget.setSerology(serology);
            },
            decoration: InputDecoration(
                hintText: 'HIV medical',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: hivviralload,
          onChanged: (val) {
            serology.hivviralload = val;
            print("object ${serology.hivviralload}");
            widget.setSerology(serology);
          },
          decoration: InputDecoration(
              hintText: 'HIV viral load',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: cd4count,
            onChanged: (val) {
              serology.cd4count = val;
              print("object ${serology.cd4count}");
              widget.setSerology(serology);
            },
            decoration: InputDecoration(
                hintText: 'CD4 count',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: aso,
          onChanged: (val) {
            serology.aso = val;
            print("object ${serology.aso}");
            widget.setSerology(serology);
          },
          decoration: InputDecoration(
              hintText: 'ASO (Qualitative/Quantitative',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: rf,
            onChanged: (val) {
              serology.rf = val;
              print("object ${serology.rf}");
              widget.setSerology(serology);
            },
            decoration: InputDecoration(
                hintText: 'RF (Qualitative/Quantitative)',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: crp,
          onChanged: (val) {
            serology.crp = val;
            print("object ${serology.crp}");
            widget.setSerology(serology);
          },
          decoration: InputDecoration(
              hintText: 'CRP',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: ana,
          onChanged: (val) {
            serology.ana = val;
            print("object ${serology.ana}");
            widget.setSerology(serology);
          },
          decoration: InputDecoration(
              hintText: 'ANA',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: betahcg,
          onChanged: (val) {
            serology.betahcg = val;
            print("object ${serology.betahcg}");
            widget.setSerology(serology);
          },
          decoration: InputDecoration(
              hintText: 'betaHCG (Qualitative/Quantitative)',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: coombs,
          onChanged: (val) {
            serology.coombs = val;
            print("object ${serology.coombs}");
            widget.setSerology(serology);
          },
          decoration: InputDecoration(
              hintText: 'Coombs(D/I)',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
      ],
    );
  }

  Widget _buildTumorForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: tpsa,
          onChanged: (val) {
            tumor.tpsa = val;
            print("object ${tumor.tpsa}");
            widget.setTumor(tumor);
          },
          decoration: InputDecoration(
              hintText: 'TPSA',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: afp,
          onChanged: (val) {
            tumor.afp = val;
            print("object ${tumor.afp}");
            widget.setTumor(tumor);
          },
          decoration: InputDecoration(
              hintText: 'AFP',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: cea,
          onChanged: (val) {
            tumor.cea = val;
            print("object ${tumor.cea}");
            widget.setTumor(tumor);
          },
          decoration: InputDecoration(
              hintText: 'CEA',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: ca125,
          onChanged: (val) {
            tumor.ca125 = val;
            print("object ${tumor.ca125}");
            widget.setTumor(tumor);
          },
          decoration: InputDecoration(
              hintText: 'CA 125',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: ca19,
          onChanged: (val) {
            tumor.ca19 = val;
            print("object ${tumor.ca19}");
            widget.setTumor(tumor);
          },
          decoration: InputDecoration(
              hintText: 'CA 19.9',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
      ],
    );
  }

  Widget _buildEndocrinologyForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: t3,
          onChanged: (val) {
            endocrinology.t3 = val;
            print("object ${endocrinology.t3}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'T3 (Total/Free',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: t4,
            onChanged: (val) {
              endocrinology.t4 = val;
              print("object ${endocrinology.t4}");
              widget.setEndocrinology(endocrinology);
            },
            decoration: InputDecoration(
                hintText: 'T4 (Total/Free)',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: pth,
          onChanged: (val) {
            endocrinology.pth = val;
            print("object ${endocrinology.pth}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'PTH',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: tsh,
            onChanged: (val) {
              endocrinology.tsh = val;
              print("object ${endocrinology.tsh}");
              widget.setEndocrinology(endocrinology);
            },
            decoration: InputDecoration(
                hintText: 'TSH',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: fsh,
          onChanged: (val) {
            endocrinology.fsh = val;
            print("object ${endocrinology.fsh}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'FSH',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: lh,
            onChanged: (val) {
              endocrinology.lh = val;
              print("object ${endocrinology.lh}");
              widget.setEndocrinology(endocrinology);
            },
            decoration: InputDecoration(
                hintText: 'LH',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: progesterone,
          onChanged: (val) {
            endocrinology.progesterone = val;
            print("object ${endocrinology.progesterone}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'Progesterone',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            controller: estradiol,
            onChanged: (val) {
              endocrinology.estradiol = val;
              print("object ${endocrinology.estradiol}");
              widget.setEndocrinology(endocrinology);
            },
            decoration: InputDecoration(
                hintText: 'Estradiol',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          controller: testosterone,
          onChanged: (val) {
            endocrinology.testosterone = val;
            print("object ${endocrinology.testosterone}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'Testosterone',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: prolactin,
          onChanged: (val) {
            endocrinology.prolactin = val;
            print("object ${endocrinology.prolactin}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'Prolactin',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: serumcortisol,
          onChanged: (val) {
            endocrinology.serumcortisol = val;
            print("object ${endocrinology.serumcortisol}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'Serum Cortisol',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: serumcalcitonin,
          onChanged: (val) {
            endocrinology.serumcalcitonin = val;
            print("object ${endocrinology.serumcalcitonin}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'Serum Calcitonin',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: erythropoietin,
          onChanged: (val) {
            endocrinology.erythropoietin = val;
            print("object ${endocrinology.erythropoietin}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'Erythropoietin',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: growthhormone,
          onChanged: (val) {
            endocrinology.growthhormone = val;
            print("object ${endocrinology.growthhormone}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'Growth Hormone',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: vitb12,
          onChanged: (val) {
            endocrinology.vitb12 = val;
            print("object ${endocrinology.vitb12}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'Vit B12',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          controller: vitD,
          onChanged: (val) {
            endocrinology.vitD = val;
            print("object ${endocrinology.vitD}");
            widget.setEndocrinology(endocrinology);
          },
          decoration: InputDecoration(
              hintText: 'Vit D',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
