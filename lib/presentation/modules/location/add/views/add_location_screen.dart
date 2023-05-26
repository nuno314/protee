import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/models/location.dart';
import '../../../../../data/models/place_prediction.dart';
import '../../../../../data/models/response.dart';
import '../../../../base/base.dart';
import '../../../../common_bloc/cubit/location_cubit.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/add_location_bloc.dart';

part 'add_location.action.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({Key? key}) : super(key: key);

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends StateBase<AddLocationScreen>
    with AfterLayoutMixin {
  final _nameController = InputContainerController();
  final _addressController = InputContainerController();
  late Debouncer _debouncer;
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();
  bool showPredictions = false;

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;
  late final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await _locateMe();
  }

  @override
  AddLocationBloc get bloc => BlocProvider.of(context);

  bool get isKeyboardVisibility => keyboardVisibilityController.isVisible;

  late String _mapStyle = '';
  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map/style.txt').then((string) {
      _mapStyle = string;
    });

    _debouncer = Debouncer<String>(const Duration(milliseconds: 500), search);
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<AddLocationBloc, AddLocationState>(
      listener: _blocListener,
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: LayoutBuilder(
            builder: (ctx, constaints) => Container(
              color: themeColor.scaffoldBackgroundColor,
              child: Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      initialCameraPosition: _kGooglePlex,
                      myLocationEnabled: true,
                      onMapCreated: _controller.complete,
                      mapType: MapType.satellite,
                      myLocationButtonEnabled: true,
                      markers: markers.values.toSet(),
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      compassEnabled: false,
                      tiltGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                      onTap: _onTapLocation,
                    ),
                  ),
                  _buildLocationSearch(state, constaints),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationSearch(
    AddLocationState state,
    BoxConstraints constaints,
  ) {
    return KeyboardVisibilityBuilder(
      controller: keyboardVisibilityController,
      builder: (ctx, isKeyboardVisible) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: themeColor.scaffoldBackgroundColor,
          ),
          height: isKeyboardVisibility
              ? device.height / 2
              : device.height / 2 + state.predictions.length * 10,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Text(
                      'Thêm Địa Điểm',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: themeColor.primaryColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -14,
                    left: -16,
                    child: IconButton(
                      icon: const Icon(
                        Icons.navigate_before_outlined,
                      ),
                      onPressed: _onBack,
                    ),
                  ),
                  Positioned(
                    top: -14,
                    right: -14,
                    child: IconButton(
                      icon: const Icon(
                        Icons.done,
                      ),
                      onPressed: _onAddLocation,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              InputContainer(
                controller: _nameController,
                title: 'Tên địa điểm',
                fillColor: themeColor.white,
                required: true,
              ),
              const SizedBox(height: 16),
              InputContainer(
                controller: _addressController,
                title: 'Vị trí',
                fillColor: themeColor.white,
                required: true,
                onTextChanged: (value) => _debouncer.value = value,
              ),
              Expanded(
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.predictions.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () =>
                        _onTapPlace(state.predictions.elementAt(index)),
                    child:
                        Text(state.predictions.elementAt(index).description!),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onAddLocation() {
    if (_nameController.text.isEmpty) {
      _nameController.setError('Vui lòng nhập tên địa điểm');
      return;
    }

    if (_addressController.text.isEmpty) {
      _addressController.setError('Vui lòng nhập vị trí');
      return;
    }
  }
}
