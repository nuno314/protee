import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common/utils.dart';
import '../../../../data/models/place_prediction.dart';
import '../../../../data/models/response.dart';
import '../../../base/base.dart';
import '../../../common_widget/export.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import '../bloc/search_direction_bloc.dart';

part 'search_direction.action.dart';

class SearchDirectionArgs {
  final String? id;
  final GoogleMapPlace? initial;

  SearchDirectionArgs({this.id, this.initial});
}

class SearchDirectionScreen extends StatefulWidget {
  const SearchDirectionScreen({Key? key}) : super(key: key);

  @override
  State<SearchDirectionScreen> createState() => _SearchDirectionScreenState();
}

class _SearchDirectionScreenState extends StateBase<SearchDirectionScreen> {
  late Debouncer _debouncer;

  @override
  SearchDirectionBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer<String>(const Duration(milliseconds: 500), search);
  }

  @override
  Widget build(BuildContext context) {
    _themeData = context.theme;
    trans = translate(context);
    return BlocConsumer<SearchDirectionBloc, SearchDirectionState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          title: trans.routeSearch,
          headerColor: themeColor.primaryColor,
          titleColor: themeColor.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                InputContainer(
                  fillColor: themeColor.white,
                  title: trans.destination,
                  hint: trans.enterDestination,
                  onTextChanged: (value) => _debouncer.value = value,
                ),
                state.predictions.length > state.places.length
                    ? Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: state.predictions.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () => _onTapPrediction(
                              state.predictions.elementAt(index),
                            ),
                            child: Text(
                              state.predictions.elementAt(index).description!,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: state.places.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () =>
                                _onTapPlace(state.places.elementAt(index)),
                            child: Text(
                              '''${state.places.elementAt(index).name!}, ${state.places.elementAt(index).formattedAddress!}''',
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
}
