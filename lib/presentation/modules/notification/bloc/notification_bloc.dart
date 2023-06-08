import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../base/base.dart';
import '../interactor/notification_interactor.dart';
import '../repository/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc
    extends AppBlocBase<NotificationEvent, NotificationState> {
  late final _interactor = NotificationInteractorImpl(
    NotificationRepositoryImpl(),
  );

  NotificationBloc()
      : super(NotificationInitial(viewModel: const _ViewModel())) {
    on<NotificationEvent>(_onNotificationEvent);
  }

  Future<void> _onNotificationEvent(
    NotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {}
}
