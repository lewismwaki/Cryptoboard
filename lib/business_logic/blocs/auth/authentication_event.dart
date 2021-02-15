part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final AuthenticatedUser user;

  AuthenticationUserChanged({this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationDeleteRequested extends AuthenticationEvent {
  final AuthenticatedUser user;

  AuthenticationDeleteRequested({this.user});

  @override
  List<Object> get props => [user];
}
