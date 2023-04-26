part of '../home_page_screen.dart';

extension MapViewUI on _HomePageScreenState {
  Widget _buildMapView(HomePageState state) {
    return Container(
      height: 300,
      padding: const EdgeInsets.only(bottom: 16.0),
      child: const GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(1, 1)),
      ),
    );
  }
}
