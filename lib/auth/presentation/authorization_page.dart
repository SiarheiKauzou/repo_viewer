import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';
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
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    WebViewCookieManager().clearCookies();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          if (request.url
              .startsWith(GithubAuthenticator.redirectUri.toString())) {
            widget.onAuthorizationCodeRedirectAttemp(Uri.parse(request.url));
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onPageFinished: (url) {
          setState(() {
            _isLoading = false;
          });
        },
      ))
      ..clearCache()
      ..loadRequest(widget.authorizationUri);
    super.initState();
  }
}
