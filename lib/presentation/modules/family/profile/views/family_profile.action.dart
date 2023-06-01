part of 'family_profile_screen.dart';

extension FamilyProfileAction on _FamilyProfileScreenState {
  void _blocListener(BuildContext context, FamilyProfileState state) {
    _controller.refreshCompleted();
  }

  void onRefresh() {
    bloc.add(GetFamilyProfileEvent());
  }

  void _onBack() {
    Navigator.pop(context);
  }

  void _onTapAddMember() {
    Navigator.pushNamed(context, RouteList.addMember);
  }
}
