import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../data/data_source/remote/app_api_service.dart';
import '../../../../data/data_source/remote/rest_api_repository/rest_api_repository.dart';
import '../../../../data/models/notification_model.dart';
import '../../../../di/di.dart';
import '../../../base/base.dart';
import '../interactor/notification_interactor.dart';
import '../repository/notification_repository.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc
    extends AppBlocBase<NotificationEvent, NotificationState> {
  final socket = injector.get<AppApiService>();
  late final _interactor = NotificationInteractorImpl(
    NotificationRepositoryImpl(),
  );
  NotificationBloc()
      : super(NotificationInitial(viewModel: const _ViewModel())) {
    on<GetNotificationEvent>(_onGetNotificationEvent);
    on<LoadMoreNotificationEvent>(_onLoadMoreNotificationEvent);
    on<ReadNotificationEvent>(_onReadNotificationEvent);
  }

  Future<void> _onGetNotificationEvent(
    GetNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final data = await _interactor.getData();
    emit(
      state.copyWith<NotificationInitial>(
        viewModel: state.viewModel.copyWith(
          notifications: data,
          canLoadMore: _interactor.pagination.canNext,
        ),
      ),
    );
  }

  FutureOr<void> _onLoadMoreNotificationEvent(
    LoadMoreNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final moreData = await _interactor.loadMoreData();
    emit(
      state.copyWith<NotificationInitial>(
        viewModel: state.viewModel.copyWith(
          notifications: [...state.viewModel.notifications, ...moreData],
          canLoadMore: _interactor.pagination.canNext,
        ),
      ),
    );
  }

  FutureOr<void> _onReadNotificationEvent(
    ReadNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final res = await _interactor.readNoti(event.id);
    if (res != null) {
      final data = state.notifications;
      data.firstWhere((element) => element.id == res.id).isRead = true;
      emit(
        state.copyWith<NotificationInitial>(
          viewModel: state.viewModel.copyWith(
            notifications: data,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onMarkAllNotificationEvent(
    MarkAllNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final res = await _interactor.readAllNoti();
  }
}
