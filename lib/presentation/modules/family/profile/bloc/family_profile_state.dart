// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'family_profile_bloc.dart';

class _ViewModel {
  final User? user;
  final Family? family;
  final List<User> members;
  final List<JoinFamilyRequest> requests;
  const _ViewModel({
    this.user,
    this.family,
    this.members = const [],
    this.requests = const [],
  });

  _ViewModel copyWith({
    User? user,
    Family? family,
    List<User>? members,
    List<JoinFamilyRequest>? requests,
  }) {
    return _ViewModel(
      user: user ?? this.user,
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

  User? get user => viewModel.user;
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
