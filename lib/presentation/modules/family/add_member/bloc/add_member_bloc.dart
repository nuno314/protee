import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';

part 'add_member_event.dart';
part 'add_member_state.dart';

class AddMemberBloc extends AppBlocBase<AddMemberEvent, AddMemberState> {
  final _restApi = injector.get<AppApiService>().client;
  final _localDataManager = injector.get<AppApiService>().localDataManager;

  AddMemberBloc() : super(AddMemberInitial(viewModel: const _ViewModel())) {
    on<GetInvitationCodeEvent>(_onGetInvitationCodeEvent);
  }

  Future<void> _onGetInvitationCodeEvent(
    GetInvitationCodeEvent event,
    Emitter<AddMemberState> emit,
  ) async {
    final res = await _restApi.getInviteCode();

    if (res != null) {
      _localDataManager.notifyUserChanged(res.user);
      emit(
        state.copyWith<AddMemberInitial>(
          viewModel: state.viewModel.copyWith(
            invitationCode: res.code,
          ),
        ),
      );
    }
  }
}
