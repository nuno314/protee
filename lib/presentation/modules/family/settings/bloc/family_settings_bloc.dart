import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../data/models/family.dart';
import '../../../../base/base.dart';
import '../interactor/family_settings_interactor.dart';
import '../repository/family_settings_repository.dart';

part 'family_settings_event.dart';
part 'family_settings_state.dart';

class FamilySettingsBloc
    extends AppBlocBase<FamilySettingsEvent, FamilySettingsState> {
  late final _interactor = FamilySettingsInteractorImpl(
    FamilySettingsRepositoryImpl(),
  );

  FamilySettingsBloc({Family? family})
      : super(FamilySettingsInitial(viewModel: const _ViewModel())) {
    on<FamilySettingsEvent>(_onFamilySettingsEvent);
  }

  Future<void> _onFamilySettingsEvent(
    FamilySettingsEvent event,
    Emitter<FamilySettingsState> emit,
  ) async {}
}
