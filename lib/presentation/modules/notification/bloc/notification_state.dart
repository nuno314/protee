part of 'notification_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
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