part of 'add_location_screen.dart';

extension AddLocationAction on _AddLocationScreenState {
  void _blocListener(BuildContext context, AddLocationState state) {
    if (state.places.isNotEmpty) {
      showPredictions = true;
    }
  }

  Future<void> _locateMe() async {
    showLoading();
    await context.read<LocationCubit>().let((cubit) async {
      final granted = await checkLocationPermission();
      if (granted == false) {
        await showNoticeDialog(
          context: context,
          message: trans.pleaseEnableGPS,
        );
      }
      if (cubit.isValidPlace != true) {
        await cubit.refreshLocation();
      }
      hideLoading();
      final controller = await _controller.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 14,
            target: LatLng(
              cubit.state.currentPlace!.location!.lat!,
              cubit.state.currentPlace!.location!.lng!,
            ),
          ),
        ),
      );
    });
  }

  void search(String? value) {
    bloc.add(SearchLocationEvent(value ?? ''));
  }
}
