part of 'join_family_requests_bloc.dart';

class _ViewModel {
  final List<JoinFamilyRequest> requests;
  final bool canLoadMore;

  const _ViewModel({
    this.canLoadMore = false,
    this.requests = const [],
  });

  _ViewModel copyWith({
    List<JoinFamilyRequest>? requests,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      requests: requests ?? this.requests,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}

abstract class JoinFamilyRequestsState {
  final _ViewModel viewModel;

  JoinFamilyRequestsState(this.viewModel);

  T copyWith<T extends JoinFamilyRequestsState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == JoinFamilyRequestsState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  List<JoinFamilyRequest> get requests => viewModel.requests;
  bool get canLoadMore => viewModel.canLoadMore;
}

class JoinFamilyRequestsInitial extends JoinFamilyRequestsState {
  JoinFamilyRequestsInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class RequestApprovedState extends JoinFamilyRequestsState {
  RequestApprovedState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  JoinFamilyRequestsInitial: (viewModel) => JoinFamilyRequestsInitial(
        viewModel: viewModel,
      ),
  RequestApprovedState: (viewModel) => RequestApprovedState(
        viewModel: viewModel,
      ),
};
