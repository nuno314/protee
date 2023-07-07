import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/family.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';
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

  final _restApi = injector.get<AppApiService>().client;
  final _local = injector.get<AppApiService>().localDataManager;


  FamilyProfileBloc()
      : super(FamilyProfileInitial(viewModel: const _ViewModel())) {
    on<GetFamilyProfileEvent>(_onGetFamilyProfileEvent);
    on<RemoveMemberEvent>(_onRemoveMemberEvent);
    on<LeaveFamilyEvent>(_onLeaveFamilyEvent);
    on<UpdateUpToParentEvent>(_onUpdateUpToParentEvent);
    on<UpdateDownToChildEvent>(_onUpdateDownToChildEvent);
    on<GetUserEvent>(_onGetUserEvent);

    add(GetUserEvent());
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
    final members = asOrNull<List<UserFamily>>(data[1]) ?? []
      ..sort((a, b) {
        if (a.role == FamilyRole.child) {
          return -1;
        } else if (b.role == FamilyRole.child) {
          return 1;
        }
        return -1;
      });
    emit(
      state.copyWith<FamilyProfileInitial>(
        viewModel: state.viewModel.copyWith(
          family: asOrNull(data[0]),
          members: members,
          requests: (state.user?.isParent == true) ? asOrNull(data[2]) : null,
        ),
      ),
    );
  }

  FutureOr<void> _onRemoveMemberEvent(
    RemoveMemberEvent event,
    Emitter<FamilyProfileState> emit,
  ) async {
    final user = state.viewModel.members.firstWhereOrNull(
      (element) => element.user!.id == event.member.user!.id,
    );
    if (user != null) {
      final res = await _interactor.removeMember(user.id!);
      if (res) {
        final members = [...state.viewModel.members]
          ..removeWhere((element) => element.id == user.id);
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
    if (res?.id.isNotNullOrEmpty == true) {
      emit(
        state.copyWith<LeaveFamilyState>(),
      );
    } else {
      emit(
        state.copyWith<LeaveFamilyFailed>(),
      );
    }
  }

  FutureOr<void> _onUpdateUpToParentEvent(
    UpdateUpToParentEvent event,
    Emitter<FamilyProfileState> emit,
  ) async {
    final res = await _interactor.updateParent(event.id);
    final members = [...state.members];
    for (final member in members) {
      if (member.id == res?.id) {
        member.role = FamilyRole.child;
      }
    }
    emit(
      state.copyWith<AdjustRoleState>(
        viewModel: state.viewModel.copyWith(
          members: members,
        ),
      ),
    );
  }

  FutureOr<void> _onUpdateDownToChildEvent(
    UpdateDownToChildEvent event,
    Emitter<FamilyProfileState> emit,
  ) async {
    final res = await _interactor.updateChild(event.id);
    final members = [...state.members];
    for (final member in members) {
      if (member.id == res?.id) {
        member.role = FamilyRole.parent;
      }
    }
    emit(
      state.copyWith<AdjustRoleState>(
        viewModel: state.viewModel.copyWith(
          members: members,
        ),
      ),
    );
  }

  FutureOr<void> _onGetUserEvent(
    GetUserEvent event,
    Emitter<FamilyProfileState> emit,
  ) async {
    final user = await _restApi.getUserProfile();
    _local.notifyUserChanged(user);
    emit(
      state.copyWith<UserInitialState>(
        viewModel: state.viewModel.copyWith(
          user: user,
        ),
      ),
    );
  }
}
