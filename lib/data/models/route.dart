import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_checker.dart';
import 'location.dart';
import 'response.dart';

part 'route.g.dart';

@JsonSerializable()
class GoogleRoute {
  @JsonKey(name: 'bounds')
  final Viewport? bounds;
  @JsonKey(name: 'legs')
  final List<Leg>? legs;

  GoogleRoute({
    this.bounds,
    this.legs,
  });
  factory GoogleRoute.fromJson(Map<String, dynamic> json) =>
      _$GoogleRouteFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleRouteToJson(this);
}

@JsonSerializable()
class Leg {
  @JsonKey(name: 'distance')
  final TextValue? distance;
  @JsonKey(name: 'duration')
  final TextValue? duration;
  @JsonKey(name: 'steps')
  final List<Step>? steps;

  Leg({
    this.distance,
    this.duration,
    this.steps,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => _$LegFromJson(json);

  Map<String, dynamic> toJson() => _$LegToJson(this);
}

@JsonSerializable()
class Step {
  @JsonKey(name: 'distance')
  final TextValue? distance;
  @JsonKey(name: 'duration')
  final TextValue? duration;
  @JsonKey(name: 'start_location')
  final Location? start;
  @JsonKey(name: 'end_location')
  final Location? end;
  @JsonKey(name: 'polyline')
  final GooglePolyline? polyline;

  Step({
    this.distance,
    this.duration,
    this.start,
    this.end,
    this.polyline,
  });

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);
}

@JsonSerializable()
class TextValue {
  @JsonKey(name: 'text', fromJson: asOrNull)
  final String? text;
  @JsonKey(name: 'value', fromJson: asOrNull)
  final int? value;

  TextValue({
    this.text,
    this.value,
  });

  factory TextValue.fromJson(Map<String, dynamic> json) =>
      _$TextValueFromJson(json);

  Map<String, dynamic> toJson() => _$TextValueToJson(this);
}

@JsonSerializable()
class GooglePolyline {
  @JsonKey(name: 'points', fromJson: asOrNull)
  final String? points;

  GooglePolyline({this.points});

  factory GooglePolyline.fromJson(Map<String, dynamic> json) =>
      _$GooglePolylineFromJson(json);

  Map<String, dynamic> toJson() => _$GooglePolylineToJson(this);
}
