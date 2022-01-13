import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/providers/pharmacy_provider.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/ui/pharmacy/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class MyPharmacy extends StatefulWidget {
  @override
  _MyPharmacyState createState() => _MyPharmacyState();
}

class _MyPharmacyState extends State<MyPharmacy> {
  var drug_id = null;
  var drug_name = "";
  var priceController = new TextEditingController();
  var drugController = new TextEditingController();

  void _openPriceForm(BuildContext context) {
    bool adding = false;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height - 40,
                child: Form(
                  child: Column(
                    children: [
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Price',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                      adding ? CircularProgressIndicator() : Container(),
                      Container(
                        width: 100.0,
                        child: OutlinedButton(
                            onPressed: () async {
                              setState(() {
                                adding = true;
                              });
                              var res = await Provider.of<PharmacyProvider>(
                                      context,
                                      listen: false)
                                  .addDrugToPharmacy(
                                  drugController.text, drug_id, priceController.text)
                                  .whenComplete(() {
                                setState(() {
                                  adding = true;
                                });
                                CustomSnackBar.success(
                                    message: 'Item successfully added');
                              });
                              if (res['status']) {
                                setState(() {
                                  Provider.of<PharmacyProvider>(context,
                                          listen: false)
                                      .getMyPharmacy();
                                });

                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('Add')),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var pharmacyProvider =
        Provider.of<PharmacyProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Header(),
          Expanded(
              child: ListView(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<List<dynamic>>(
                    future: Provider.of<DrugProvider>(context).getDrugsLocal(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.data == null) {
                          return Center(
                            child: Text('No data to show'),
                          );
                        }
                        return Container(
                          width: width(context) * 0.7,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Autocomplete(
                              optionsBuilder: (TextEditingValue value) {
                                // When the field is empty
                                if (value.text.isEmpty) {
                                  return [];
                                }

                                // The logic to find out which ones should appear
                                // Milkessa: implemented a search mechanism that is organized and alphabetical
                                List<dynamic> drugRes;
                                for (int i = 0; i < 2; i++) {
                                  if (i == 0)
                                    drugRes = snapshot.data
                                        .where((element) => element['name']
                                            .startsWith(value.text))
                                        .toList();
                                  else
                                    drugRes.addAll(snapshot.data
                                        .where((element) =>
                                            element['name']
                                                .contains(value.text) &
                                            !element['name']
                                                .startsWith(value.text))
                                        .toList());
                                }
                                return drugRes;
                              },
                              onSelected: (value) {
                                setState(() {
                                  drug_id = value['id'].toString();
                                  drug_name = value['name'];
                                });
                              },
                              displayStringForOption: (option) =>
                                  option['name'],
                              fieldViewBuilder: (BuildContext context,
                                  TextEditingController
                                      fieldTextEditingController,
                                  FocusNode fieldFocusNode,
                                  VoidCallback onFieldSubmitted) {
                                drugController = fieldTextEditingController;
                                return Container(
                                  child: TextFormField(
                                    controller: drugController,
                                    focusNode: fieldFocusNode,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        hintText: 'Name Of Drug'),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Container(
                    width: 100,
                    child: MaterialButton(
                      onPressed: () {},
                      child: ElevatedButton(
                        onPressed: () {
                          _openPriceForm(context);
                        },
                        child: Text('Add'),
                      ),
                    ),
                  )
                ],
              ),
              ListTile(
                title: Text(
                  'Item',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  'Price',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              FutureBuilder(
                  future: pharmacyProvider.getMyPharmacy(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.data == null) {
                        return Center(
                          child: Text('No data to show'),
                        );
                      }
                      return ListView(
                          shrinkWrap: true,
                          children: snapshot.data.map<Widget>((e) {
                            return ListTile(
                              title: Text(
                                e['drug_name'],
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              trailing: Text(
                                '${e['price']} Br',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            );
                          }).toList());
                    }
                  }),
            ],
          )),
          PharmacyFooter()
        ],
      ),
    ));
  }
}
