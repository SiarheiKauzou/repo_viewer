import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({
    required this.authorizationUri,
    required this.onAuthorizationCodeRedirectAttemp,
    super.key,
  });

  final Uri authorizationUri;
  final void Function(Uri redirectUrl) onAuthorizationCodeRedirectAttemp;

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(widget.authorizationUri);
    super.initState();
  }
}