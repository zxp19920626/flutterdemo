import 'dart:io';

import 'package:fezs_demo/first.dart';
import 'package:fezs_demo/video2.dart';
import 'package:fezs_demo/webview.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //Tab页的控制器，可以用来定义Tab标签和内容页的坐标
  TabController tabcontroller;

  //生命周期方法插入渲染树时调用，只调用一次
  @override
  void initState() {
    super.initState();
    tabcontroller = new TabController(
        length: 3, //Tab页的个数
        vsync: this //动画效果的异步处理，默认格式
        );
  }

  //生命周期方法构建Widget时调用
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new TabBarView(
          controller: tabcontroller,
          children: <Widget>[
            //创建之前写好的三个页面，万物皆是Widget
            new FirstPage(),
            new WebViewPage(),
            new CameraApp(),
          ],
        ),
        bottomNavigationBar: new Material(
          //底部栏整体的颜色
          color: Colors.blueAccent,
          child: new TabBar(
            controller: tabcontroller,
            tabs: <Tab>[
              new Tab(text: "选择", icon: new Icon(Icons.android)),
              new Tab(text: "webview", icon: new Icon(Icons.home)),
              new Tab(text: "录象", icon: new Icon(Icons.accessibility)),
            ],
            //tab被选中时的颜色，设置之后选中的时候，icon和text都会变色
            labelColor: Colors.amber,
            //tab未被选中时的颜色，设置之后选中的时候，icon和text都会变色
            unselectedLabelColor: Colors.black,
          ),
        ));
  }

  //组件即将销毁时调用
  @override
  void dispose() {
    //释放内存，节省开销
    tabcontroller.dispose();
    super.dispose();
  }
}
