import 'dart:async';

import 'package:bloc/bloc.dart';

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

  FamilyProfileBloc()
      : super(FamilyProfileInitial(viewModel: const _ViewModel())) {
    on<GetFamilyProfileEvent>(_onGetFamilyProfileEvent);
  }

  Future<void> _onGetFamilyProfileEvent(
    GetFamilyProfileEvent event,
    Emitter<FamilyProfileState> emit,
  ) async {
    final family = await _interactor.getFamilyProfile();
    final members = await _interactor.getFamilyMembers();
    emit(
      state.copyWith<FamilyProfileInitial>(
        viewModel: state.viewModel.copyWith(
          family: family,
          members: members,
        ),
      ),
    );
  }
}
