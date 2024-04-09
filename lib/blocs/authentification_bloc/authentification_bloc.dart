import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

part 'authentification_event.dart';
part 'authentification_state.dart';

class AuthenticationBloc extends Bloc<AuthentificationEvent, AuthenticationState> {
  final UserRepository userRepository;
	late final StreamSubscription<User?> _userSubscription;

	AuthenticationBloc({
		required this.userRepository
	}) : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((user) {
			add(AuthentificationUserChanged(user));
		});
		on<AuthentificationUserChanged>((event, emit) {
			if(event.user != null) {
				emit(AuthenticationState.authenticated(event.user!));
			} else {
				emit(const AuthenticationState.unauthenticated());
			}
		});
  }
	
	@override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}