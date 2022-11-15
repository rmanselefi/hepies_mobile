
import 'package:flutter/material.dart';
import 'package:hepius/providers/consult.dart';
import 'package:hepius/ui/doctor/consults/post_consult.dart';
import 'package:hepius/ui/pharmacy/ui/consults/consult_list.dart';
import 'package:hepius/ui/pharmacy/ui/consults/search_list.dart';
import 'package:hepius/widgets/footer.dart';
import 'package:provider/provider.dart';
import 'package:hepius/util/helpers.dart';

class ShareConsult extends StatefulWidget {
  final user_id;
  ShareConsult(this.user_id);
  @override
  _ShareConsultState createState() => _ShareConsultState();
}

class _ShareConsultState extends State<ShareConsult> {
  ScrollController _parentScrollController = ScrollController();
  var _search = new TextEditingController();
  bool isOnSearch = false;
  // XFile file;
  List<dynamic> interests = [];
  List<dynamic> subList = [];

  var name = '';

  void setInterests() {
    ConsultProvider().getInterests().then((value) {
      if (!mounted) return;
      setState(() {
        interests = value;
        subList = interests.sublist(0, 5);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setInterests();
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[CircularProgressIndicator()],
  );
  @override
  Widget build(BuildContext context) {
    ConsultProvider consult = Provider.of<ConsultProvider>(context);

    List<dynamic> interest = interests
        .where((element) => element['interest'].toLowerCase().contains(name))
        .toList();

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              controller: _parentScrollController,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      height: MediaQuery.of(context).size.height / 18,
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            isOnSearch = false;
                          });
                        },
                        controller: _search,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () {
                                // await consult.notifySearch();
                                setState(() {
                                  isOnSearch = true;
                                });
                               
                              },
                              child: Icon(Icons.search)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1)),
                          hintText: "Search consults  ...",
                          labelStyle: TextStyle(color: Colors.black45),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        height: MediaQuery.of(context).size.height / 16,
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PostConsult()));
                          },
                          decoration: InputDecoration(
                            hintText: "Share your consults....",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1)),
                          ),
                        )),
                    Divider(),
                    isOnSearch
                        ? Expanded(
                            child: SearchList(
                                widget.user_id,
                                interest,
                                capitalize(_search.text.toString()),
                                _parentScrollController),
                          )
                        : Expanded(
                            child: PharmacyConsultList(widget.user_id, interest,
                                _parentScrollController),
                          )
                  ],
                ),
              ),
            )),
            Footer(),
          ],
        ),
      ),
    );
  }
}
