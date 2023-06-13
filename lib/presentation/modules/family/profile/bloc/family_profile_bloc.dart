import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/models/family.dart';
import '../../../../../data/models/user.dart';
import '../../../../base/base.dart';
import '../interactor/family_profile_interactor.dart';
import '../repository/family_profile_repository.dart';

part 'family_profile_event.dart';
part 'family_profile_state.dart';

class FamilyProfileBloc
    extends AppBlocBase<FamilyProfileEvent, FamilyProfileState> {
  late final _interactor = FamilyProfileInteractorImpl(
    FamilyProfileRepositoryImpl(),
  );

  FamilyProfileBloc(User? user)
      : super(FamilyProfileInitial(viewModel: _ViewModel(user: user))) {
    on<GetFamilyProfileEvent>(_onGetFamilyProfileEvent);
    on<RemoveMemberEvent>(_onRemoveMemberEvent);
    on<LeaveFamilyEvent>(_onLeaveFamilyEvent);
  }

  Future<void> _onGetFamilyProfileEvent(
    GetFamilyProfileEvent event,
    Emitter<FamilyProfileState> emit,
  ) async {
    final data = await Future.wait(
      [
        _interactor.getFamilyProfile(),
        _interactor.getFamilyMembers(),
        if (state.user?.isParent == true) _interactor.getRequests(),
      ],
      eagerError: true,
    );

    emit(
      state.copyWith<FamilyProfileInitial>(
        viewModel: state.viewModel.copyWith(
          family: asOrNull(data[0]),
          members: asOrNull(data[1]),
          requests: (state.user?.isParent == true) ? asOrNull(data[2]) : null,
        ),
      ),
    );
  }

  FutureOr<void> _onRemoveMemberEvent(
    RemoveMemberEvent event,
    Emitter<FamilyProfileState> emit,
  ) async {
    final user = state.viewModel.members
        .firstWhereOrNull((element) => element.user!.id == event.member.id);
    if (user != null) {
      final res = await _interactor.removeMember(user.userId!);
      if (res) {
        final members = [...state.viewModel.members]
          ..removeWhere((element) => element.userId == user.userId);
        emit(
          state.copyWith<RemoveMemberState>(
            viewModel: state.viewModel.copyWith(
              members: members,
            ),
          ),
        );
      }
    }
  }

  FutureOr<void> _onLeaveFamilyEvent(
    LeaveFamilyEvent event,
    Emitter<FamilyProfileState> emit,
  ) async {
    final res = await _interactor.leaveFamily();
    if (res) {
      emit(state.copyWith<LeaveFamilyState>());
    }
  }
}
