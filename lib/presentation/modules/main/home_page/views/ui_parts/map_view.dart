part of '../home_page_screen.dart';

extension MapViewUI on _HomePageScreenState {
  Widget _buildMapView(HomePageState state) {
    return Container(
      height: 300,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex!,
        onMapCreated: _controller.complete,
        myLocationEnabled: true,
      ),
    );
  }
}
