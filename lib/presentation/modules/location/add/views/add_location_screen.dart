import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils.dart';
import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/models/location.dart';
import '../../../../../data/models/place_prediction.dart';
import '../../../../../data/models/response.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_bloc/cubit/location_cubit.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/shadow.dart';
import '../../../../theme/theme_button.dart';
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
  late var _scrollController = ScrollController();
  late Debouncer _debouncer;
  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();
  bool showPredictions = false;

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  void onError(ErrorData error) {
    hideLoading();
    if (error.message?.toLowerCase().contains('exist') == true) {
      showErrorDialog(trans.locationDoesExist);
    }
  }

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

  late final String _mapStyle = '';
  @override
  void initState() {
    super.initState();

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
          body: Container(
            color: themeColor.scaffoldBackgroundColor,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  myLocationEnabled: true,
                  onMapCreated: _onMapCreated,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  markers: markers.values.toSet(),
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  tiltGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  liteModeEnabled: false,
                  onTap: _onTapLocation,
                  padding: EdgeInsets.only(bottom: device.height * 0.2),
                ),
                DraggableScrollableSheet(
                  maxChildSize: 0.85,
                  minChildSize: 0.28,
                  builder: (context, scrollController) {
                    _scrollController = scrollController;
                    return Container(
                      decoration: BoxDecoration(
                        color: themeColor.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(
                          parent: NeverScrollableScrollPhysics(),
                        ),
                        controller: scrollController,
                        child: Column(
                          children: [
                            _buildLocationSearch(
                              state,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  width: device.width,
                  child: Container(
                    color: themeColor.white,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        ThemeButton.primary(
                          context: context,
                          title: 'Thêm địa điểm',
                          onPressed: _onAddLocation,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 40,
                  child: InkWell(
                    onTap: _onBack,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        boxShadow: boxShadowlight,
                        color: themeColor.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: SvgPicture.asset(
                        Assets.svg.icChevronLeft,
                        color: themeColor.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationSearch(
    AddLocationState state,
  ) {
    return KeyboardVisibilityBuilder(
      controller: keyboardVisibilityController,
      builder: (ctx, isKeyboardVisible) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: themeColor.white,
          ),
          height: isKeyboardVisibility
              ? device.height / 2
              : device.height / 2 + state.predictions.length * 10,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
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

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle('');
    _controller.complete(controller);
  }
}
