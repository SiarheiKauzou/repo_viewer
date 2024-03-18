import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/auth/domain/auth_failure.dart';
import 'package:repo_viewer/auth/infrastructure/github_authenticator.dart';

part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initial() = _Initial;

  const factory AuthState.unauthenticated() = _Unauthenticated;

  const factory AuthState.authenticated() = _Authenticated;

  const factory AuthState.failure(AuthFailure failure) = _Failure;
}

typedef AuthUriCallback = Future<Uri> Function(Uri);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._authenticator) : super(const AuthState.initial());

  final GithubAuthenticator _authenticator;

  Future<void> checkAndUpdateAuthenticationStatus() async {
    state = (await _authenticator.isSignedIn())
        ? const AuthState.authenticated()
        : const AuthState.unauthenticated();
  }

  Future<void> signIn(AuthUriCallback authorizationCallback) async {}
}
