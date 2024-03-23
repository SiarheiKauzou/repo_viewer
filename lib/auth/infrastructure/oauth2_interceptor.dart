import 'package:dio/dio.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';

class Oauth2Interceptor extends Interceptor {
  const Oauth2Interceptor(this._authenticator);

  final GithubAuthenticator _authenticator;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final credentials = await _authenticator.getSignedInCredentials();
    final modifiedOptions = options
      ..headers.addAll(credentials == null
          ? {}
          : {'Authorization': 'bearer ${credentials.accessToken}'});
    handler.next(modifiedOptions);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final errorResponse = err.response;

    if (errorResponse != null && errorResponse.statusCode == 401) {
      final credentials = await _authenticator.getSignedInCredentials();
      credentials != null && credentials.canRefresh
          ? await _authenticator.refresh(credentials)
          : await _authenticator.signOut();
    }
  }
}
