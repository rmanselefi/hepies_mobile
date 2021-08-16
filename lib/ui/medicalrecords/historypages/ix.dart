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
import 'package:hepies/ui/medicalrecords/historypages/collapse.dart';

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

class _IXState extends State<IX> {
  bool isExpanded = false;
  var hematology = new Hematology();
  var serology = new Serology();
  var chemistry = new Chemistry();
  var endocrinology = new Endocrinology();
  var urine = new Urine();
  var ix = new Investigation();
  var tumor = new Tumor();
  @override
  Widget build(BuildContext context) {
    return ExpandableTheme(
      data: const ExpandableThemeData(
        iconColor: Colors.blue,
        useInkWell: true,
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
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
              child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.redAccent, width: 3)),
                    child: ExpandablePanel(
                      collapsed: Text('Tap to see more'),
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
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
                        border: Border.all(color: Color(0xff0be9e2), width: 3)),
                    child: ExpandablePanel(
                      collapsed: Text('Tap to see more'),
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
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
}
