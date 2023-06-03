part of 'add_member_bloc.dart';

class _ViewModel {
  final String? invitationCode;
  const _ViewModel({
    this.invitationCode,
  });

  _ViewModel copyWith({String? invitationCode}) {
    return _ViewModel(
      invitationCode: invitationCode ?? this.invitationCode,
    );
  }
}

abstract class AddMemberState {
  final _ViewModel viewModel;

  AddMemberState(this.viewModel);

  T copyWith<T extends AddMemberState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == AddMemberState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  String? get invitationCode => viewModel.invitationCode;
}

class AddMemberInitial extends AddMemberState {
  AddMemberInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  AddMemberInitial: (viewModel) => AddMemberInitial(
        viewModel: viewModel,
      ),
};
