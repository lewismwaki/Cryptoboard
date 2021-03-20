part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final AuthenticatedUser user;
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = AuthenticatedUser.empty,
  });

  const AuthenticationState.unknown() : this._();
  const AuthenticationState.authenticated(AuthenticatedUser user)
      : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
        );

  const AuthenticationState.unauthenticated(AuthenticatedUser user)
      : this._(
          status: AuthenticationStatus.unauthenticated,
        );

  @override
  List<Object> get props => [status, user];
}
