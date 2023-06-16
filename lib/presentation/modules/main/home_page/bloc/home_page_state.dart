part of 'home_page_bloc.dart';

class _ViewModel {
  final User? user;
  final FamilyStatistic? statistic;
  const _ViewModel({
    this.user,
    this.statistic,
  });

  _ViewModel copyWith({
    User? user,
    FamilyStatistic? statistic,
  }) {
    return _ViewModel(
      user: user ?? this.user,
      statistic: statistic ?? this.statistic,
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
  int get members => viewModel.statistic?.numberMembers ?? 0;
  int get locations => viewModel.statistic?.numberLocations ?? 0;
  int get warnings => viewModel.statistic?.numberWarningTimes ?? 0;

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
