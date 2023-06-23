import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../base/base.dart';

part 'family_settings_event.dart';
part 'family_settings_state.dart';

class FamilySettingsBloc
    extends AppBlocBase<FamilySettingsEvent, FamilySettingsState> {
  FamilySettingsBloc()
      : super(FamilySettingsInitial(viewModel: const _ViewModel())) {
    on<FamilySettingsEvent>(_onFamilySettingsEvent);
  }

  Future<void> _onFamilySettingsEvent(
    FamilySettingsEvent event,
    Emitter<FamilySettingsState> emit,
  ) async {}
}
