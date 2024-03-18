import 'package:flutter/services.dart';
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/infrastructure/credentials_storage/credentials_storage.dart';

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
  static final redirectUrl = Uri.parse('http://localhost:3000/callback');

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
}
