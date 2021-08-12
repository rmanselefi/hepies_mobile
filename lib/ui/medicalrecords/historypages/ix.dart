import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hepies/ui/medicalrecords/historypages/collapse.dart';

class IX extends StatefulWidget {
  @override
  _IXState createState() => _IXState();
}

class _IXState extends State<IX> {
  bool isExpanded = false;

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
                            border:
                                Border.all(color: Color(0xff000000), width: 3)),
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
                                "Pathology Index",
                                style: Theme.of(context).textTheme.body2,
                              )),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
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
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Expandable(
                                collapsed: collapsed,
                                expanded: expanded,
                                theme:
                                    const ExpandableThemeData(crossFadePoint: 0),
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
                            border:
                                Border.all(color: Color(0xff000000), width: 3)),
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
                                "Radiology Index",
                                style: Theme.of(context).textTheme.body2,
                              )),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
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
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Expandable(
                                collapsed: collapsed,
                                expanded: expanded,
                                theme:
                                    const ExpandableThemeData(crossFadePoint: 0),
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
          decoration: InputDecoration(
              hintText: 'WBC Count',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Hgb',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'HCT',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'MCV',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'MCH',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'MCHC',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Plt count',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Reticulocyte',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'BG and RHE',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
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
          decoration: InputDecoration(
              hintText: 'FBS',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'RBS',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'HbA1c',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'BUN/ure',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Creatinine',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'AST/SGOT',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'ALT/SGP',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'ALP',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Bilirubin Total',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Bilirubin Direct',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Bilirubin Indirect',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Albumin',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Total Protein',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Triglyceride',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Cholesterol',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'HDL',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'LDL',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Amylase',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
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
          decoration: InputDecoration(
              hintText: 'STOOL EXAM',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
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
          decoration: InputDecoration(
              hintText: 'Widal',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'WelFelix',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'HBsAg',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'HIV medical',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'HIV viral load',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'CD4 count',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'ASO (Qualitative/Quantitative',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'RF (Qualitative/Quantitative)',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'CRP',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'ANA',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'betaHCG (Qualitative/Quantitative)',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
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
          decoration: InputDecoration(
              hintText: 'TPSA',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'AFP',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'CEA',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'CA 125',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
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
          decoration: InputDecoration(
              hintText: 'T3 (Total/Free',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'T4 (Total/Free)',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'PTH',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'TSH',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'FSH',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'LH',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Progesterone',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Estradiol',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2)))),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Testosterone',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Prolactin',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Serum Cortisol',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Serum Calcitonin',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Erythropoietin',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Growth Hormone',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Vit B12',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Vit D',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2))),
        ),
      ],
    );
  }
}
