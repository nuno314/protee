import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../common/utils.dart';
import '../../../../base/base.dart';
import '../../../../extentions/extention.dart';
import '../bloc/location_bloc.dart';

part 'location.action.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends StateBase<LocationScreen> {
  @override
  LocationBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<LocationBloc, LocationState>(
      listener: _blocListener,
      builder: (context, state) {
        return Container();
      },
    );
  }
}
