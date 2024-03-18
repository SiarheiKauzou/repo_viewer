import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/domain/auth_failure.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';
import 'package:http/http.dart' as http;

class GithubHttpClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll({'Content-Type': 'application/json'});
    return request.send();
  }
}

class GithubAuthenticator {
  const GithubAuthenticator(this._credentialsStorage);

  final CredentialsStorage _credentialsStorage;

  static const clientId = 'ef79216ecc49e3a6ecef';
  static const clientSecret = 'c8398cd1ff9ec7c0cf5737fe6d41737e7a7ed113';
  static const scopes = ['read:user', 'repo'];
  static final authorizationEndpoint =
      Uri.parse('https://github.com/login/oauth/auhorize');
  static final tokenEndpoint =
      Uri.parse('https://github.com/login/oauth/auhorize');
  static final redirectUri = Uri.parse('http://localhost:3000/callback');

  Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialsStorage.read();

      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          //TODO: refresh token
        }
      }

      return storedCredentials;
    } on PlatformException {
      return null;
    }
  }

  Future<bool> isSignedIn() =>
      getSignedInCredentials().then((credentials) => credentials != null);

  AuthorizationCodeGrant createGrant(Credentials credentials) {
    return AuthorizationCodeGrant(
      clientId,
      authorizationEndpoint,
      tokenEndpoint,
      secret: clientSecret,
      httpClient: GithubHttpClient(),
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
}
