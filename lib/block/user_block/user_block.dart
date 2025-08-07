import 'package:bloc/bloc.dart';
import 'package:test_app/block/user_block/user_event.dart';
import 'package:test_app/block/user_block/user_state.dart';
import 'package:test_app/utils/constants.dart';

import '../../domain/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    on<LoginUser>((event, emit) async {
      logger.i("LoginUser event received");

      emit(UserLoading());
      try {
        final user =
            await repository.login(event.email, event.password, event.role);
        logger.i("Login success: ${event.email}");
        emit(UserLoaded(user));
      } catch (e) {
        logger.e("Login failed: $e");
        emit(UserError(e.toString()));
      }
    });
  }
}
