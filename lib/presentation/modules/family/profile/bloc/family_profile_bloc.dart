import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../base/base.dart';
import '../interactor/family_profile_interactor.dart';
import '../repository/family_profile_repository.dart';

part 'family_profile_event.dart';
part 'family_profile_state.dart';

class FamilyProfileBloc extends AppBlocBase<FamilyProfileEvent, FamilyProfileState> {
  late final _interactor = FamilyProfileInteractorImpl(
    FamilyProfileRepositoryImpl(),
  );
  
  FamilyProfileBloc() : super(FamilyProfileInitial(viewModel: const _ViewModel())) {
    on<FamilyProfileEvent>(_onFamilyProfileEvent);
  }

  Future<void> _onFamilyProfileEvent(
    FamilyProfileEvent event,
    Emitter<FamilyProfileState> emit,
  ) async {}
}