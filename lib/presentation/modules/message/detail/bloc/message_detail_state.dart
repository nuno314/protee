part of 'message_detail_bloc.dart';

class _ViewModel {
  final List<User> members;

  const _ViewModel({
    this.members = const [],
  });

  _ViewModel copyWith({
    List<User>? members,
  }) {
    return _ViewModel(
      members: members ?? this.members,
    );
  }
}

abstract class MessageDetailState {
  final _ViewModel viewModel;

  MessageDetailState(this.viewModel);

  T copyWith<T extends MessageDetailState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == MessageDetailState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  List<User> get members => viewModel.members;
}

class MessageDetailInitial extends MessageDetailState {
  MessageDetailInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  MessageDetailInitial: (viewModel) => MessageDetailInitial(
        viewModel: viewModel,
      ),
};