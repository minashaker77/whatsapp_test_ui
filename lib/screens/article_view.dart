import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({required this.blogUrl});

  final String blogUrl;

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers =
      {Factory(() => EagerGestureRecognizer())};

  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.blogUrl,
      onWebViewCreated: (WebViewController webViewController) {
        _completer.complete(webViewController);
      },
      gestureNavigationEnabled: true,
      debuggingEnabled: true,
      javascriptMode: JavascriptMode.unrestricted,
      gestureRecognizers: gestureRecognizers,
    );
  }
}
