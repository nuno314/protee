part of 'family_profile_bloc.dart';

class _ViewModel {
  final Family? family;
  final List<User> members;
  final List<JoinFamilyRequest> requests;
  const _ViewModel({
    this.family,
    this.members = const [],
    this.requests = const [],
  });

  _ViewModel copyWith({
    Family? family,
    List<User>? members,
    List<JoinFamilyRequest>? requests,
  }) {
    return _ViewModel(
      family: family ?? this.family,
      members: members ?? this.members,
      requests: requests ?? this.requests,
    );
  }
}

abstract class FamilyProfileState {
  final _ViewModel viewModel;

  FamilyProfileState(this.viewModel);

  T copyWith<T extends FamilyProfileState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == FamilyProfileState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  Family? get family => viewModel.family;
  List<User> get members => viewModel.members;
  List<JoinFamilyRequest> get requests => viewModel.requests;
}

class FamilyProfileInitial extends FamilyProfileState {
  FamilyProfileInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  FamilyProfileInitial: (viewModel) => FamilyProfileInitial(
        viewModel: viewModel,
      ),
};
