import 'package:flutter/material.dart';
import 'package:flutter_decorated_text/flutter_decorated_text.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';

class DrugDetail extends StatefulWidget {
  final drug;
  DrugDetail(this.drug);
  @override
  _DrugDetailState createState() => _DrugDetailState();
}

class _DrugDetailState extends State<DrugDetail> {
  @override
  Widget build(BuildContext context) {
    String about = widget.drug['about'];
    List<Text> bolded = about != null
        ? _transformWord(about)
        : [
            Text('')
          ]; // Milkessa: 'double quotation ("")' changed to '[Text('')]'

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Drug Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('---'),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.drug['name'],
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('---'),
                      SizedBox(
                        width: 10.0,
                      ),
                      // Expanded(
                      //   child: IntrinsicHeight(
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.stretch,
                      //       children: bolded.map<Widget>((e) {
                      //         return Container(width: 100, child: e);
                      //       }).toList(),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: 250,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          children: [
                            DecoratedText(
                              text: about,
                              style: TextStyle(fontSize: 16),
                              rules: [
                                DecoratorRule.words(
                                  words: [
                                    "Indications",
                                    "Contraindications",
                                    "Cautions",
                                    "Interactions",
                                    "Side effects",
                                    "Side Effects",
                                    "Dose",
                                    "Administration",
                                    "Adult",
                                    "Child",
                                    "Pediatric",
                                    "Storage",
                                    "Oral",
                                    "I.V",
                                    "I.M",
                                    "Topical",
                                    "Apply",
                                    "I.U",
                                    "Note",
                                    "Storage",
                                  ],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
            Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0))),
                child: Footer())
          ],
        ),
      ),
    );
  }

  List<Text> _transformWord(String word) {
    var bold_words = [
      "Indications",
      "Contraindications",
      "Cautions",
      "Interactions",
      "Side effects",
      "Storage"
    ];

    List<String> name = word.split(' ');
    List<Text> textWidgets = [];
    for (int i = 0; i < name.length; i++) {
      var spe = name[i].replaceAll(RegExp(",|!|'"), "");
      // print(spe);
      if (bold_words.contains(spe)) {
        Text bold = Text(
          name[i] + ' ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        );
        textWidgets.add(bold);
      } else {
        Text normal = Text(
          name[i] + ' ',
        );
        textWidgets.add(normal);
      }
    }
    return textWidgets;
  }
}
