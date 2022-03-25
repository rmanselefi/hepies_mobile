import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({Key key, this.url, this.title}) : super(key: key);
  var url;
  var title;

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.cancel_outlined,
              size: 30,
              color: Colors.white38,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hepius ${widget.title}"),
              Row(
                children: [
                  Icon(
                    Icons.lock,
                    size: 15,
                  ),
                  Expanded(
                    child: Text(
                      "${widget.url}",
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              )
            ],
          ),
          backgroundColor: Colors.black54),
      body: WebView(
          initialUrl: "${widget.url}",
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            return NavigationDecision.navigate;
          }),
    );
  }
}
