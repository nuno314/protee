part of 'family_profile_bloc.dart';

class _ViewModel {
  final User? user;
  final Family? family;
  final List<UserFamily> members;
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
    List<UserFamily>? members,
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
  List<UserFamily> get members => viewModel.members;
  List<JoinFamilyRequest> get requests => viewModel.requests;
}

class FamilyProfileInitial extends FamilyProfileState {
  FamilyProfileInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class RemoveMemberState extends FamilyProfileState {
  RemoveMemberState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class LeaveFamilyState extends FamilyProfileState {
  LeaveFamilyState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class AdjustRoleState extends FamilyProfileState {
  AdjustRoleState({
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
  RemoveMemberState: (viewModel) => RemoveMemberState(
        viewModel: viewModel,
      ),
  LeaveFamilyState: (viewModel) => LeaveFamilyState(
        viewModel: viewModel,
      ),
  AdjustRoleState: (viewModel) => AdjustRoleState(
        viewModel: viewModel,
      ),
};
