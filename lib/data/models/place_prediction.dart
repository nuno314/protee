import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_checker.dart';

part 'place_prediction.g.dart';

@JsonSerializable()
class PlacePrediction {
  @JsonKey(name: 'description', fromJson: asOrNull)
  final String? description;
  @JsonKey(name: 'place_id', fromJson: asOrNull)
  final String? placeId;
  @JsonKey(name: 'reference', fromJson: asOrNull)
  final String? reference;
  final List<String>? types;

  PlacePrediction({
    this.description,
    this.placeId,
    this.reference,
    this.types,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) =>
      _$PlacePredictionFromJson(json);
  Map<String, dynamic> toJson() => _$PlacePredictionToJson(this);
}
