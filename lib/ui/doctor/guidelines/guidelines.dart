import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/providers/guidelines.dart';
import 'package:hepies/widgets/header.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Guidelines extends StatefulWidget {
  @override
  _GuidelinesState createState() => _GuidelinesState();
}

class _GuidelinesState extends State<Guidelines> {
  String drugName = '';

  bool downloading = false;
  String downloadingStr = "No data";
  var progress = 0.0;
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();
    print("dirdirdir ${dir.path}");
    path = '${dir.path}/$uniqueFileName';

    return path;
  }

  Future downloadFile(String imageUrl, int id) async {
    try {
      Dio dio = Dio();

      String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

      var savePath = await getFilePath(fileName);
      Random random = new Random();
      var randid = random.nextInt(10000);
      var dirloc = "/sdcard/download/";
      await dio.download(imageUrl, dirloc + randid.toString() + ".pdf",
          onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          // download = (rec / total) * 100;
          progress = ((rec / total)).toDouble();
        });
      });
      setState(() {
        downloading = false;
      });
      var result = await GuidelinesProvider()
          .updateStatus(randid.toString() + ".pdf", id);
      if (result['status']) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message:
                'File downloaded to download folder as ${randid.toString() + ".pdf"}',
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void viewFile(String directory) {
    var path = "/sdcard/download/" + directory;
    PDFView(
      filePath: path,
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: false,
      pageFling: false,
      onRender: (_pages) {
        setState(() {
          pages = _pages;
          isReady = true;
        });
      },
      onError: (error) {
        print(error.toString());
      },
      onPageError: (page, error) {
        print('$page: ${error.toString()}');
      },
      onViewCreated: (PDFViewController pdfViewController) {
        _controller.complete(pdfViewController);
      },
      onPageChanged: (int page, int total) {
        print('page change: $page/$total');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Header(),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: TextField(
                onChanged: (val) {
                  var drugs =
                      Provider.of<GuidelinesProvider>(context, listen: false)
                          .guidelines;
                  var drug = setState(() {
                    drugName = val;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Search",
                    fillColor: Colors.white70),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          downloading
              ? LinearPercentIndicator(
                  width: 250.0,
                  lineHeight: 14.0,
                  percent: progress,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                )
              : Container(),
          downloading ? Text((progress * 100).toString() + "%") : Container(),
          SizedBox(
            height: 5.0,
          ),
          FutureBuilder<List<dynamic>>(
              future: Provider.of<GuidelinesProvider>(context).getGuidelines(),
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

                  print("guidelinesguidelines ${snapshot.data}");
                  List<dynamic> drugs = snapshot.data
                      .where((element) => element['name'].contains(drugName))
                      .toList();
                  return Container(
                    height: 2 * MediaQuery.of(context).size.height / 3,
                    child: ListView(
                      shrinkWrap: true,
                      children: drugs.map<Widget>((e) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print("object ${e['url']}");
                                e['status'] != null
                                    ? viewFile(e['directory'])
                                    : downloadFile(e['url'], e['id']);
                              },
                              child: Container(
                                  width: 370,
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 10.0),
                                  child: Text(
                                    e['name'] != null ? e['name'] : '',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        decoration: TextDecoration.underline),
                                  )),
                            ),
                            IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.redAccent,
                                ))
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
