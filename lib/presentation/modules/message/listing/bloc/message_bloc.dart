import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../../common/services/auth_service.dart';
import '../../../../../data/models/message.dart';
import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';
import '../interactor/message_interactor.dart';
import '../repository/message_repository.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends AppBlocBase<MessageEvent, MessageState> {
  late final _interactor = MessageInteractorImpl(
    MessageRepositoryImpl(),
  );

  final baseSocketUrl = 'ws://protee-be.herokuapp.com/';

  final _socketResponse = StreamController<String>();
  Stream<String> get getResponse => _socketResponse.stream;
  late final Socket _socket;
  final _localDataManager = injector.get<AuthService>();

  MessageBloc(User user)
      : super(MessageInitial(viewModel: _ViewModel(user: user))) {
    on<GetMessagesEvent>(_onGetMessagesEvent);
    on<LoadMoreMessagesEvent>(_onLoadMoreMessagesEvent);

    on<SendMessageEvent>(_onSendMessageEvent);

    // _socket = io(baseSocketUrl, {
    //   'accessToken': _localDataManager.token!,
    //   'familyId': state.user!.familyId!,
    // });
    // _socket
    //   ..connect()
    //   ..on('message', print)
    //   ..on('join', print);
    // add(GetMessageEvent());
    // add(SendMessageEvent('Hello world'));
  }

  Future<void> _onGetMessagesEvent(
    GetMessagesEvent event,
    Emitter<MessageState> emit,
  ) async {
    final data = await _interactor.getData();
    emit(
      state.copyWith<MessageInitial>(
        viewModel: state.viewModel.copyWith(
          messages: data,
          canLoadMore: _interactor.pagination.canNext,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreMessagesEvent(
    LoadMoreMessagesEvent event,
    Emitter<MessageState> emit,
  ) async {
    final moreData = await _interactor.loadMoreData();
    emit(
      state.copyWith<MessageInitial>(
        viewModel: state.viewModel.copyWith(
          messages: [...state.viewModel.messages, ...moreData],
          canLoadMore: _interactor.pagination.canNext,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _socketResponse.close();
    return super.close();
  }

  FutureOr<void> _onSendMessageEvent(
    SendMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    emit(
      state.copyWith<MessageInitial>(
        viewModel: state.viewModel.copyWith(
          messages: [
            Message(
              user: state.user,
              content: event.message,
              createdAt: DateTime.now(),
            ),
            ...state.messages.reversed.toList(),
          ],
        ),
      ),
    );
    final res = await _interactor.sendMessage(event.message);
  }
}
