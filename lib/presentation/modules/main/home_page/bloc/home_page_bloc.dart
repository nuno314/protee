import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../data/models/user.dart';
import '../../../../base/base.dart';
import '../interactor/home_page_interactor.dart';
import '../repository/home_page_repository.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends AppBlocBase<HomePageEvent, HomePageState> {
  late final _interactor = HomePageInteractorImpl(
    HomePageRepositoryImpl(),
  );

  HomePageBloc({User? user})
      : super(HomePageInitial(viewModel: _ViewModel(user: user))) {
    on<HomePageEvent>(_onHomePageEvent);
  }

  Future<void> _onHomePageEvent(
    HomePageEvent event,
    Emitter<HomePageState> emit,
  ) async {}
}
