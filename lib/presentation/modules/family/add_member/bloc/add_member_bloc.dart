import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../base/base.dart';
import '../interactor/add_member_interactor.dart';
import '../repository/add_member_repository.dart';

part 'add_member_event.dart';
part 'add_member_state.dart';

class AddMemberBloc extends AppBlocBase<AddMemberEvent, AddMemberState> {
  late final _interactor = AddMemberInteractorImpl(
    AddMemberRepositoryImpl(),
  );

  AddMemberBloc() : super(AddMemberInitial(viewModel: const _ViewModel())) {
    on<GetInvitationCodeEvent>(_onGetInvitationCodeEvent);
  }

  Future<void> _onGetInvitationCodeEvent(
    GetInvitationCodeEvent event,
    Emitter<AddMemberState> emit,
  ) async {
    final code = await _interactor.getInvitationCode();
    emit(
      state.copyWith<AddMemberInitial>(
        viewModel: state.viewModel.copyWith(
          invitationCode: code,
        ),
      ),
    );
  }
}
