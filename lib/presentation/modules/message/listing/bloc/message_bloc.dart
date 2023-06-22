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

  late final Socket _socket;
  final _localDataManager = injector.get<AuthService>();

  MessageBloc(User user)
      : super(MessageInitial(viewModel: _ViewModel(user: user))) {
    on<GetMessagesEvent>(_onGetMessagesEvent);
    on<LoadMoreMessagesEvent>(_onLoadMoreMessagesEvent);

    on<SendMessageEvent>(_onSendMessageEvent);
    on<MessageUpcomingEvent>(_onMessageUpcomingEvent);

    _socket = io(
      baseSocketUrl,
      OptionBuilder().setTransports(['websocket']).setQuery({
        'accessToken': _localDataManager.token!,
        'familyId': user.familyId!,
      }).build(),
    );

    _socket.on(
      'message',
      (data) {
        add(MessageUpcomingEvent(Message.fromJson(data)));
      },
    );
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
    await _interactor.sendMessage(event.message);
  }

  FutureOr<void> _onMessageUpcomingEvent(
    MessageUpcomingEvent event,
    Emitter<MessageState> emit,
  ) {
    emit(
      state.copyWith<MessageInitial>(
        viewModel: state.viewModel.copyWith(
          messages: [
            event.message,
            ...state.messages.reversed.toList(),
          ],
        ),
      ),
    );
  }
}
