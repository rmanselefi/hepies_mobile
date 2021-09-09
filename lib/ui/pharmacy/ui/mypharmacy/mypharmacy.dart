import 'package:flutter/material.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/providers/pharmacy_provider.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/ui/pharmacy/widgets/header.dart';
import 'package:provider/provider.dart';

class MyPharmacy extends StatefulWidget {
  @override
  _MyPharmacyState createState() => _MyPharmacyState();
}

class _MyPharmacyState extends State<MyPharmacy> {
  var drug_id = "";
  var drug_name = "";
  var priceController = new TextEditingController();

  void _openPriceForm(BuildContext context) {
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            var res = await Provider.of<PharmacyProvider>(
                                    context,
                                    listen: false)
                                .addDrugToPharmacy(
                                    drug_name, drug_id, priceController.text);
                            if (res['status']) {
                              setState(() {
                                Provider.of<PharmacyProvider>(context,listen: false).getMyPharmacy();
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text('Add'))
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
    List<dynamic> drugs = Provider.of<DrugProvider>(context).drugs;
    var pharmacyProvider = Provider.of<PharmacyProvider>(context,listen: false);
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
                  Container(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Autocomplete(
                        optionsBuilder: (TextEditingValue value) {
                          // When the field is empty
                          if (value.text.isEmpty) {
                            return [];
                          }

                          // The logic to find out which ones should appear
                          return drugs.where((drug) {
                            return drug['name']
                                .toLowerCase()
                                .contains(value.text.toLowerCase());
                          });
                        },
                        onSelected: (value) {
                          setState(() {
                            drug_id = value['id'].toString();
                            drug_name = value['name'];
                          });
                        },
                        displayStringForOption: (option) => option['name'],
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted) {
                          return Container(
                            child: TextFormField(
                              controller: fieldTextEditingController,
                              focusNode: fieldFocusNode,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  hintText: 'Name Of Drug'),
                            ),
                          );
                        },
                      ),
                    ),
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
