import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/providers/pharmacy_provider.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/pharmacy/welcome.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/ui/pharmacy/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MyPharmacy extends StatefulWidget {
  @override
  _MyPharmacyState createState() => _MyPharmacyState();
}

class _MyPharmacyState extends State<MyPharmacy> {
  var drug_id = null;
  var drug_name = "";
  var pharmacy_id;
  var formStatus = "add";
  var priceController = new TextEditingController();
  var drugController = new TextEditingController();
  var drugEditController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();

  void _openPriceForm(BuildContext context) {
    bool adding = false;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height - 40,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            validator: (val) =>
                                val.isEmpty ? 'Price is required' : null,
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
                                final form = formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  setState(() {
                                    adding = true;
                                  });
                                  var res = await Provider.of<PharmacyProvider>(
                                          context,
                                          listen: false)
                                      .addDrugToPharmacy(drugController.text,
                                          drug_id, priceController.text)
                                      .whenComplete(() {
                                    setState(() {
                                      adding = false;
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

                                    Navigator.pushAndRemoveUntil<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            MyPharmacy(),
                                      ),
                                      ModalRoute.withName('/'),
                                    );
                                    ;
                                  }
                                }
                              },
                              child: Text('Add')),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _openEditForm(BuildContext context, var drug_name) {
    bool adding = false;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height - 40,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text('Edit Pharmacy'),
                        ),
                        FutureBuilder<List<dynamic>>(
                          future: Provider.of<DrugProvider>(context)
                              .getDrugsLocal(),
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
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
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
                                              .where((element) =>
                                                  element['name']
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
                                      drugEditController =
                                          fieldTextEditingController;
                                      return Container(
                                        width: 200,
                                        child: TextFormField(
                                          controller: drugEditController,
                                          focusNode: fieldFocusNode,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            validator: (val) =>
                                val.isEmpty ? 'Price is required' : null,
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
                                final form = formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  setState(() {
                                    adding = true;
                                  });

                                  var res = await Provider.of<PharmacyProvider>(
                                          context,
                                          listen: false)
                                      .updateMyPharmacy(
                                          pharmacy_id,
                                          drugEditController.text,
                                          drug_id,
                                          priceController.text)
                                      .whenComplete(() {
                                    setState(() {
                                      adding = false;
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

                                    Navigator.pushAndRemoveUntil<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            MyPharmacy(),
                                      ),
                                      ModalRoute.withName('/'),
                                    );
                                  }
                                }
                              },
                              child: Text('Update')),
                        )
                      ],
                    ),
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
    UserProvider nav = Provider.of<UserProvider>(context);

    return WillPopScope(
      onWillPop: () {
        nav.changeNavSelection(NavSelection.home);
        Navigator.pop(context);
        return;
      },
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
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
                      future:
                          Provider.of<DrugProvider>(context).getDrugsLocal(),
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
                                                BorderRadius.circular(10.0),
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
                            if (drugController.text != '') {
                              _openPriceForm(context);
                            } else {
                              showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                      message: 'Please enter drug first!'));
                            }
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
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    'Price',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                                trailing: Column(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          priceController.text = e['price'];
                                          drugEditController.text =
                                              e['drug_name'];
                                          pharmacy_id = e['id'];
                                        });
                                        _openEditForm(context, e['drug_name']);
                                      },
                                      label: Text(
                                        '${e['price']} Br',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      icon:
                                          Icon(Icons.edit, color: Colors.blue),
                                    ),
                                  ],
                                ),
                              );
                            }).toList());
                      }
                    }),
              ],
            )),
            Center(child: PharmacyFooter())
          ],
        ),
      )),
    );
  }
}
