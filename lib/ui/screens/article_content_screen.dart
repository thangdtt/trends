import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trends/data/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleContentScreen extends StatefulWidget {
  static const routeName = '/article';
  @override
  _ArticleContentScreenState createState() => _ArticleContentScreenState();
}

class _ArticleContentScreenState extends State<ArticleContentScreen> {
  final _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final article = ModalRoute.of(context).settings.arguments as Article;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding: false,
      body: WebView(
        initialUrl: article.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
