part of 'home_page_screen.dart';

extension HomePageAction on _HomePageScreenState {
  void _blocListener(BuildContext context, HomePageState state) {
    hideLoading();
    _refreshController
      ..refreshCompleted()
      ..loadComplete();

    if (state is UserUpdatedState) {
      if (state.user?.isNull == true) {
        showNoticeConfirmDialog(
          context: context,
          message: trans.notInFamily,
          title: trans.inform,
          onConfirmed: () {
            Navigator.pushNamed(
              context,
              RouteList.addMember,
            );
          },
        );
      } else {}
    }
  }

  void _onRefresh() {
    bloc.add(InitHomePageEvent());
  }

  void onTapAddMember() {
    Navigator.pushNamed(context, RouteList.addMember);
  }

  void onTapJoinFamily() {
    Navigator.pushNamed(context, RouteList.joinFamily);
  }

  void onTapAddLocation() {
    Navigator.pushNamed(context, RouteList.addLocation);
  }

  void onTapLocationList() {
    Navigator.pushNamed(
      context,
      RouteList.locationListing,
      arguments: LocationListingArgs(
        children: bloc.state.members
            .where((element) => element.isChildren == true)
            .toList(),
      ),
    );
  }

  void onTapMemberStatistic() {
    Navigator.pushNamed(context, RouteList.familyProfile);
  }

  void onTapLocationStatistic() {
    Navigator.pushNamed(
      context,
      RouteList.locationListing,
      arguments: LocationListingArgs(
        children: bloc.state.members
            .where((element) => element.isChildren == true)
            .toList(),
      ),
    );
  }

  void onTapWarningStatistic() {
    Navigator.pushNamed(
      context,
      RouteList.locationListing,
      arguments: LocationListingArgs(
        tabIdx: bloc.state.user?.isParent == true ? 1 : 0,
        children: bloc.state.members
            .where((element) => element.isChildren == true)
            .toList(),
      ),
    );
  }

  void onTapMessage() {
    if (bloc.state.user?.familyId.isNullOrEmpty == true) {
      showNoticeConfirmDialog(
        context: context,
        message: trans.notInFamily,
        title: trans.inform,
        onConfirmed: () {
          Navigator.pushNamed(
            context,
            RouteList.addMember,
          );
        },
      );
    } else {
      Navigator.pushNamed(
        context,
        RouteList.messenger,
        arguments: bloc.state.user!,
      );
    }
  }

  void onTapFamilyProfile() {
    Navigator.pushNamed(
      context,
      RouteList.familyProfile,
    );
  }
}
