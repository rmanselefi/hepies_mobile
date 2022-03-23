import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key key}) : super(key: key);

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
              Text("Hepius Privacy Policy"),
              Row(
                children: [
                  Icon(
                    Icons.lock,
                    size: 15,
                  ),
                  Text(
                    "https://www.qemertech.com/hepius/",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              )
            ],
          ),
          backgroundColor: Colors.black54),
      body: WebView(
          initialUrl: "https://www.qemertech.com/hepius/",
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            return NavigationDecision.navigate;
          }),
    );
  }
}
