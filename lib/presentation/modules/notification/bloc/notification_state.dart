// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_bloc.dart';

class _ViewModel {
  final List<NotificationModel> notifications;
  final bool? canLoadMore;
  const _ViewModel({
    this.notifications = const [],
    this.canLoadMore,
  });

  _ViewModel copyWith({
    List<NotificationModel>? notifications,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      notifications: notifications ?? this.notifications,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}

abstract class NotificationState {
  final _ViewModel viewModel;

  NotificationState(this.viewModel);

  T copyWith<T extends NotificationState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == NotificationState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  List<NotificationModel> get notifications => viewModel.notifications;
  bool get canLoadMore => viewModel.canLoadMore ?? false;
}

class NotificationInitial extends NotificationState {
  NotificationInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  NotificationInitial: (viewModel) => NotificationInitial(
        viewModel: viewModel,
      ),
};
