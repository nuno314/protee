import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../data/data_source/remote/app_api_service.dart';
import '../../../../di/di.dart';
import '../../../base/base.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc
    extends AppBlocBase<NotificationEvent, NotificationState> {

  final socket = injector.get<AppApiService>();

  NotificationBloc()
      : super(NotificationInitial(viewModel: const _ViewModel())) {
    on<NotificationEvent>(_onNotificationEvent);
  }

  Future<void> _onNotificationEvent(
    NotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {}
}
