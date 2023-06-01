part of 'family_profile_bloc.dart';

class _ViewModel {
  final Family? family;
  final List<User> members;
  const _ViewModel({
    this.family,
    this.members = const [],
  });

  _ViewModel copyWith({
    Family? family,
    List<User>? members,
  }) {
    return _ViewModel(
      family: family ?? this.family,
      members: members ?? this.members,
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
