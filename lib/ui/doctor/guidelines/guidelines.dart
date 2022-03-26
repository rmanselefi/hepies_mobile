import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/providers/guidelines.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:hive/hive.dart';
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
  int downloadId;
  CancelToken token = CancelToken();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  // Milkessa: using hive as a local database and implementing checkStatus and changeStatus methods
  Future<void> initHive() async {
    Directory dir = await getApplicationDocumentsDirectory();
    await Hive.init(dir.path);
    Hive.openBox('Status');
  }

  bool checkStatus(String pdfName) {
    Box hive = Hive.box('status');
    if (hive.get(pdfName) != null)
      return hive.get(pdfName);
    else
      return false;
  }

  void changeStatus(String pdfName, bool status) {
    Box hive = Hive.box('status');
    hive.put(pdfName, status);
  }

  @override
  void initState() {
    // TODO: implement initState
    initHive();
    super.initState();
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();
    // print("dirdirdir ${dir.path}");
    path = '${dir.path}/$uniqueFileName';
    // print('Path---------> ' + path);
    return path;
  }

  Future downloadFile(String imageUrl, int id) async {
    downloadId = id;
    try {
      print("working download again");
      setState(() {
        downloading = true;
        // download = (rec / total) * 100;
        progress = 0.0;
      });
      Dio dio = Dio();

      String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

      var savePath = await getFilePath(fileName);
      Random random = new Random();
      var randid = random.nextInt(10000);
      var dirloc = "./download/";
      await dio.download(
        imageUrl,
        savePath + id.toString() + ".pdf",
        onReceiveProgress: (rec, total) {
          setState(() {
            // download = (rec / total) * 100;
            progress = ((rec / total)).toDouble();
          });
        },
        cancelToken: token,
      );
      // .onError((DioError error, stackTrace) async {
      //   await dio.close();
      //   print('Dio client is closed');
      //   return Future.delayed(Duration(microseconds: 1));
      // });
      setState(() {
        downloading = false;
      });
      var result = await GuidelinesProvider()
          .updateStatus(randid.toString() + ".pdf", id);
      if (result['status']) {
        print('Download path------------>' + savePath + id.toString() + ".pdf");
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message:
                'File downloaded to download folder as ${randid.toString() + ".pdf"}',
          ),
        );
        changeStatus(id.toString(), true);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> viewFile(
      String directory, String id, BuildContext context) async {
    String fileName = directory.substring(directory.lastIndexOf("/") + 1);
    var path = await getFilePath(fileName);
    print('The file path is ------->' + path);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(title: Text(id + '.pdf')),
                  body: Center(
                    child: PDFView(
                      filePath: path + id.toString() + ".pdf",
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
                        changeStatus(id.toString(), false);
                      },
                      onPageError: (page, error) {
                        print('$page: ${error.toString()}');
                      },
                      // onViewCreated: (PDFViewController pdfViewController) {
                      //   _controller.complete(pdfViewController);
                      // },
                      onPageChanged: (int page, int total) {
                        print('page change: $page/$total');
                      },
                    ),
                  ),
                )));
  }

// Milkessa: added delete functionality
  void deleteFile(String directory, String id) async {
    String fileName = directory.substring(directory.lastIndexOf("/") + 1);
    var path = await getFilePath(fileName);
    print('path-----------> ' + path);
    Directory dir = Directory(path + id.toString() + ".pdf");
    await dir
        .delete(recursive: true)
        .then((onValue) => showTopSnackBar(
              context,
              CustomSnackBar.success(
                message: 'File deleted successfully!',
              ),
            ))
        .onError((error, stackTrace) => showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: 'Failed to delete file!',
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
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
                    drugName = val.toUpperCase();
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
              ? Row(
                  children: [
                    LinearPercentIndicator(
                      width: 250.0,
                      lineHeight: 14.0,
                      percent: progress,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.blue,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          token.cancel('Download canceled!');
                          showTopSnackBar(
                            context,
                            CustomSnackBar.success(
                              message: 'Download canceled successfully!',
                            ),
                          );
                          downloading = false;
                          changeStatus(downloadId.toString(), false);
                        });
                      },
                      icon: Icon(Icons.cancel),
                    ),
                  ],
                )
              : Container(),
          downloading
              ? Text((progress * 100).toStringAsFixed(2) + "%")
              : Container(),
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

                  List<dynamic> guidlines = snapshot
                      .data // Milkessa: the list name 'drugs' changed to 'guidelines'
                      .where((element) =>
                          element['name'].toUpperCase().contains(drugName))
                      .toList();
                  // print(guidlines.toString());
                  return Container(
                    height: 3 * MediaQuery.of(context).size.height / 4,
                    child: ListView(
                      shrinkWrap: true,
                      children: guidlines.map<Widget>((e) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Milkessa: Implemented download and delete functions
                              Flexible(
                                flex: 3,
                                child: Container(
                                    width: width(context) * 0.7,
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 10.0),
                                    child: Text(
                                      e['name'] != null ? e['name'] : '',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        decoration: TextDecoration.underline,
                                      ),
                                    )),
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    checkStatus(e['id'].toString())
                                        ? ((progress * 100)
                                                    .toStringAsFixed(2) ==
                                                "100.00")
                                            ? Flexible(
                                                child: TextButton(
                                                  onPressed: () async {
                                                    print("object ${e['url']}");
                                                    await viewFile(
                                                        e['url'],
                                                        e['id'].toString(),
                                                        context);
                                                  },
                                                  child: Text(
                                                    'Open',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.blue,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container()
                                        : Container(),
                                    SizedBox(width: 6),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      onPressed: () {
                                        if (token.isCancelled) {
                                          token = new CancelToken();
                                        }
                                        print(checkStatus(e['id'].toString()));
                                        if (!checkStatus(e['id'].toString())) {
                                          setState(() {
                                            downloadFile(e['url'], e['id']);
                                            changeStatus(
                                                e['id'].toString(), true);
                                          });
                                        } else
                                          setState(() {
                                            deleteFile(
                                                e['url'], e['id'].toString());
                                            changeStatus(
                                                e['id'].toString(), false);
                                          });
                                      },
                                      icon: Icon(
                                        checkStatus(e['id'].toString())
                                            ? Icons.delete_outline
                                            : Icons.download_outlined,
                                        color: checkStatus(e['id'].toString())
                                            ? Colors.redAccent
                                            : Colors.greenAccent[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              }),
          Footer(),
        ],
      ),
    );
  }
}
