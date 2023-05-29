part of 'location_listing_screen.dart';

extension LocationListingAction on _LocationListingScreenState {
  void _blocListener(BuildContext context, LocationListingState state) {
    hideLoading();
  }

  void onRefresh() {
    bloc.add(GetLocationsEvent());
  }

  void loadMore() {
    bloc.add(LoadMoreLocationsEvent());
  }
}
