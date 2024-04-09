part of 'authentification_bloc.dart';

 class AuthentificationEvent extends Equatable {
  const AuthentificationEvent();

  @override
  List<Object> get props => [];
}
class AuthentificationUserChanged extends AuthentificationEvent{
  final User? user;
const AuthentificationUserChanged(this.user);
}