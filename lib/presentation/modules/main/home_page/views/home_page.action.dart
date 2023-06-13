part of 'home_page_screen.dart';

extension HomePageAction on _HomePageScreenState {
  void _blocListener(BuildContext context, HomePageState state) {}

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
    Navigator.pushNamed(context, RouteList.locationListing);
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
            RouteList.familyProfile,
            arguments:
                injector.get<AppApiService>().localDataManager.currentUser,
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
