// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'message_bloc.dart';

class _ViewModel {
  final User? user;
  final bool? canLoadMore;
  final List<Message> messages;
  const _ViewModel({
    this.user,
    this.messages = const [],
    this.canLoadMore,
  });

  _ViewModel copyWith({
    User? user,
    List<Message>? messages,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      user: user ?? this.user,
      messages: messages ?? this.messages,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}

abstract class MessageState {
  final _ViewModel viewModel;

  MessageState(this.viewModel);

  T copyWith<T extends MessageState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == MessageState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  User? get user => viewModel.user;
  bool get canLoadMore => viewModel.canLoadMore ?? false;
  List<Message> get messages => viewModel.messages;
}

class MessageInitial extends MessageState {
  MessageInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class SendMessageState extends MessageState {
  SendMessageState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  MessageInitial: (viewModel) => MessageInitial(
        viewModel: viewModel,
      ),
  SendMessageState: (viewModel) => SendMessageState(
        viewModel: viewModel,
      ),
};
