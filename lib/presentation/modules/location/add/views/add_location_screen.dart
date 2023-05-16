import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils.dart';
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

  late String _mapStyle = '';
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map/style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<AddLocationBloc, AddLocationState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          title: 'Thêm địa điểm',
          headerColor: themeColor.primaryColor,
          titleColor: themeColor.white,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 220,
                child: GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  myLocationEnabled: true,
                  onMapCreated: (controller) {
                    controller.setMapStyle(_mapStyle);
                    _controller.complete(controller);
                  },
                  mapType: MapType.hybrid,
                  myLocationButtonEnabled: true,
                ),
              ),
              Divider(
                height: 32,
                thickness: 16,
                color: themeColor.primaryColorLight.withOpacity(0.2),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InputContainer(
                  title: 'Tên địa điểm',
                  controller: _nameController,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  suffixIconPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: InputContainer(
                  title: 'Địa chỉ',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  suffixIconPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
