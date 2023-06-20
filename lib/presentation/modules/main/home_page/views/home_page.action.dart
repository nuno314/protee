part of 'home_page_screen.dart';

extension HomePageAction on _HomePageScreenState {
  void _blocListener(BuildContext context, HomePageState state) {
    hideLoading();
    _refreshController
      ..refreshCompleted()
      ..loadComplete();
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
      arguments: LocationListingArgs(children: bloc.state.members),
    );
  }

  void onTapMemberStatistic() {
    Navigator.pushNamed(context, RouteList.familyProfile);
  }

  void onTapLocationStatistic() {
    Navigator.pushNamed(context, RouteList.locationListing);
  }

  void onTapWarningStatistic() {
    Navigator.pushNamed(context, RouteList.locationListing);
  }

  void onTapMessage() {
    Navigator.pushNamed(
      context,
      RouteList.messenger,
      arguments: bloc.state.user!,
    );
  }

  void onTapFamilyProfile() {
    if (bloc.state.user?.isNull == true) {
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
        RouteList.familyProfile,
        arguments: injector.get<AppApiService>().localDataManager.currentUser,
      );
    }
  }
}
