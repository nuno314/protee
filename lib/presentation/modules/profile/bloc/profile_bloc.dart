import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../data/models/user.dart';
import '../../../base/base.dart';
import '../interactor/profile_interactor.dart';
import '../repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends AppBlocBase<ProfileEvent, ProfileState> {
  late final _interactor = ProfileInteractorImpl(
    ProfileRepositoryImpl(),
  );
  
  ProfileBloc() : super(ProfileInitial(viewModel: const _ViewModel())) {
    on<ProfileEvent>(_onProfileEvent);
  }

  Future<void> _onProfileEvent(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {}
}