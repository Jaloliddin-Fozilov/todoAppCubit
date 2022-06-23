import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial(User(id: '1', name: 'hellojon'))) {
    on<UserEvent>((event, emit) {});
  }
  User get currentUser {
    return state.user!;
  }
}
