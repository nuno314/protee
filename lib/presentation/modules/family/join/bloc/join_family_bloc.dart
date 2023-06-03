import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../base/base.dart';
import '../interactor/join_family_interactor.dart';
import '../repository/join_family_repository.dart';

part 'join_family_event.dart';
part 'join_family_state.dart';

class JoinFamilyBloc extends AppBlocBase<JoinFamilyEvent, JoinFamilyState> {
  late final _interactor = JoinFamilyInteractorImpl(
    JoinFamilyRepositoryImpl(),
  );

  JoinFamilyBloc() : super(JoinFamilyInitial(viewModel: const _ViewModel())) {
    on<JoinFamilyByCodeEvent>(_onJoinFamilyByCodeEvent);
  }

  Future<void> _onJoinFamilyByCodeEvent(
    JoinFamilyByCodeEvent event,
    Emitter<JoinFamilyState> emit,
  ) async {
    final res = await _interactor.joinFamily(event.code);

    if (res) {
      emit(state.copyWith<JoinFamilySuccessfullyState>());
    }
  }
}
