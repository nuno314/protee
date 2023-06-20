part of 'home_page_bloc.dart';

class _ViewModel {
  final User? user;
  final FamilyStatistic? statistic;
  final List<UserFamily> familyMembers;
  const _ViewModel({
    this.user,
    this.statistic,
    this.familyMembers = const [],
  });

  _ViewModel copyWith({
    User? user,
    FamilyStatistic? statistic,
    List<UserFamily>? familyMembers,
  }) {
    return _ViewModel(
      user: user ?? this.user,
      statistic: statistic ?? this.statistic,
      familyMembers: familyMembers ?? this.familyMembers,
    );
  }
}

abstract class HomePageState {
  final _ViewModel viewModel;

  HomePageState(this.viewModel);

  T copyWith<T extends HomePageState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == HomePageState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  User? get user => viewModel.user;
  FamilyStatistic? get statistic => viewModel.statistic;
  int get membersStatistic => viewModel.statistic?.numberMembers ?? 0;
  int get locationsStatistic => viewModel.statistic?.numberLocations ?? 0;
  int get warningsStatistic => viewModel.statistic?.numberWarningTimes ?? 0;
  List<User> get members => viewModel.familyMembers
      .where((member) => member.user != null)
      .map((member) => member.user!)
      .toList();
}

class HomePageInitial extends HomePageState {
  HomePageInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  HomePageInitial: (viewModel) => HomePageInitial(
        viewModel: viewModel,
      ),
};
