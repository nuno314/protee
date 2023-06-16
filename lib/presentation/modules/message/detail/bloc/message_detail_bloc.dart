import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/user.dart';
import '../../../../base/base.dart';
import '../interactor/message_detail_interactor.dart';
import '../repository/message_detail_repository.dart';

part 'message_detail_event.dart';
part 'message_detail_state.dart';

class MessageDetailBloc
    extends AppBlocBase<MessageDetailEvent, MessageDetailState> {
  late final _interactor = MessageDetailInteractorImpl(
    MessageDetailRepositoryImpl(),
  );

  MessageDetailBloc()
      : super(
          MessageDetailInitial(
            viewModel: const _ViewModel(),
          ),
        ) {
    on<GetFamilyProfileEvent>(_onGetFamilyProfileEvent);
  }

  Future<void> _onGetFamilyProfileEvent(
    GetFamilyProfileEvent event,
    Emitter<MessageDetailState> emit,
  ) async {
    final data = await _interactor.getMembers();
    emit(
      state.copyWith<MessageDetailInitial>(
        viewModel: state.viewModel.copyWith(
          members: data,
        ),
      ),
    );
  }
}
