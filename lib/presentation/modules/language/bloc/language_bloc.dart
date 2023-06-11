import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';

import '../../../../di/di.dart';
import '../../../base/base.dart';
import '../../../common_bloc/app_data_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends AppBlocBase<LanguageEvent, LanguageState> {
  final _appDataBloc = injector.get<AppDataBloc>();

  LanguageBloc() : super(LanguageInitial(viewModel: const _ViewModel())) {
    on<UpdateLanguageEvent>(_onUpdateLanguageEvent);
  }

  Future<void> _onUpdateLanguageEvent(
    UpdateLanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    await _appDataBloc.changeLocale(
      event.locale,
    );

    emit(state.copyWith<LanguageUpdated>());

  }
}
