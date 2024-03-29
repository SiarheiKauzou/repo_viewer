import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/domain/auth_failure.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repo_viewer/core/shared/encoders.dart';

class GithubOAuthHttpClient extends http.BaseClient {
  final httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll({'Accept': 'application/json'});
    return httpClient.send(request);
  }
}

class GithubAuthenticator {
  const GithubAuthenticator(this._dio, this._credentialsStorage);

  final Dio _dio;
  final CredentialsStorage _credentialsStorage;

  static const clientId = 'ef79216ecc49e3a6ecef';
  static const clientSecret = 'ac46f892aee844941638a7d37eb5ec3664923212';
  static const scopes = ['read:user', 'repo'];
  static final authorizationEndpoint =
      Uri.parse('https://github.com/login/oauth/authorize');
  static final tokenEndpoint =
      Uri.parse('https://github.com/login/oauth/access_token');
  static final revocationEndpoint =
      Uri.parse('http://api.github.com/aplications/$clientId/token');
  static final redirectUri = Uri.parse('http://localhost:3000/callback');

  Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialsStorage.read();

      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          final failureOrCredentials = await refresh(storedCredentials);

          return failureOrCredentials.fold((l) => null, (r) => r);
        }
      }

      return storedCredentials;
    } on PlatformException {
      return null;
    }
  }

  Future<bool> isSignedIn() =>
      getSignedInCredentials().then((credentials) => credentials != null);

  AuthorizationCodeGrant createGrant() {
    return AuthorizationCodeGrant(
      clientId,
      authorizationEndpoint,
      tokenEndpoint,
      secret: clientSecret,
      httpClient: GithubOAuthHttpClient(),
    );
  }

  Uri getAuthorizeUri(AuthorizationCodeGrant grant) {
    return grant.getAuthorizationUrl(redirectUri, scopes: scopes);
  }

  Future<Either<AuthFailure, Unit>> handlerAuthorizationResponse({
    required AuthorizationCodeGrant grant,
    required Map<String, String> query,
  }) async {
    try {
      final httpClient = await grant.handleAuthorizationResponse(query);

      await _credentialsStorage.save(httpClient.credentials);

      return right(unit);
    } on FormatException {
      return left(const AuthFailure.storage());
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server('${e.error}: ${e.description}'));
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      final accessToken = await _credentialsStorage
          .read()
          .then((credentials) => credentials?.accessToken);

      final usernameAndPassword =
          stringToBase64.encode('$clientSecret:$clientSecret');

      try {
        await _dio.deleteUri(
          revocationEndpoint,
          data: {
            'access_token': accessToken,
          },
          options: Options(
            headers: {
              'Authorization': 'basic $usernameAndPassword',
            },
          ),
        );
      } on DioException catch (e) {
        if (e.type != DioExceptionType.connectionError) {
          rethrow;
        }
      }

      return clearCredentialsStorage();
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  Future<Either<AuthFailure, Unit>> clearCredentialsStorage() async {
    try {
      await _credentialsStorage.clear();
      return right(unit);
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  Future<Either<AuthFailure, Credentials>> refresh(
      Credentials credentials) async {
    try {
      final refreshedCredentials = await credentials.refresh(
        identifier: clientId,
        secret: clientSecret,
        httpClient: GithubOAuthHttpClient(),
      );

      await _credentialsStorage.save(refreshedCredentials);

      return right(refreshedCredentials);
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server('${e.error}: ${e.description}'));
    } on FormatException {
      return left(const AuthFailure.server());
    } on PlatformException {
      return left(const AuthFailure.server());
    }
  }
}
