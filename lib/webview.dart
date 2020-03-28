import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'dart:convert' as convert;

class WebViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _controller;

  String _title = "webview";

  String msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView交互'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "接受到js的数据:" + msg,
                style: TextStyle(
                    fontSize: 20, backgroundColor: Color.fromRGBO(44, 8, 8, 8)),
              ),
              Text(
                "\n",
              ),
              GestureDetector(
                onTap: () {
                  var list = [
                    "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3437217665,1564280326&fm=26&gp=0.jpg",
                    "https://dss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3922344982,423380743&fm=26&gp=0.jpg",
                    "https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2462146637,4274174245&fm=26&gp=0.jpg",
                    "https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4142587453,3986655608&fm=26&gp=0.jpg"
                  ];

                  String jsonStringA = convert.jsonEncode(list);

                  _controller
                      .evaluateJavascript("showToast('$jsonStringA','list')");
                },
                child: Text(
                  "点击给js发送4张图片",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                "\n",
              ),
              Container(
                height: 200,
                width: 400,
                child: WebView(
                  initialUrl:
                      "https://fedev.feng1.com/static/manager/pages/components/getAndroidData/getAndroidData.html",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) {
                    _controller = controller;
                  },
                  javascriptChannels: <JavascriptChannel>[
                    JavascriptChannel(
                        name: "fezs",
                        onMessageReceived: (JavascriptMessage message) {
                          setState(() {
                            msg = message.message;
                          });
                        }),
                  ].toSet(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
