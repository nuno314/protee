import 'package:json_annotation/json_annotation.dart';

import '../../common/utils/data_checker.dart';
import 'location.dart';
import 'place_prediction.dart';

part 'response.g.dart';

@JsonSerializable()
class GoogleMapAPIReponse {
  @JsonKey(name: 'next_page_token', fromJson: asOrNull)
  final String? nextPageToken;
  @JsonKey(name: 'results')
  final List<GoogleMapPlace>? results;
  @JsonKey(name: 'status', fromJson: asOrNull)
  final String? status;
  @JsonKey(name: 'predictions')
  final List<PlacePrediction>? predictions;
  @JsonKey(name: 'result')
  final GoogleMapPlace? result;

  GoogleMapAPIReponse({
    this.nextPageToken,
    this.results,
    this.status,
    this.predictions,
    this.result,
  });

  factory GoogleMapAPIReponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleMapAPIReponseFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleMapAPIReponseToJson(this);
}

@JsonSerializable()
class GoogleMapPlace {
  @JsonKey(name: 'business_status', fromJson: asOrNull)
  final String? businessStatus;
  @JsonKey(name: 'formatted_address', fromJson: asOrNull)
  final String? formattedAddress;
  @JsonKey(name: 'geometry')
  final Geometry? geometry;
  @JsonKey(name: 'icon', fromJson: asOrNull)
  final String? icon;
  @JsonKey(name: 'icon_background_color', fromJson: asOrNull)
  final String? iconBackgroundColor;
  @JsonKey(name: 'icon_mask_base_uri', fromJson: asOrNull)
  final String? iconMaskBaseUri;
  @JsonKey(name: 'name', fromJson: asOrNull)
  final String? name;
  @JsonKey(name: 'opening_hours')
  final OpeningHours? openingHours;
  @JsonKey(name: 'photos', fromJson: asOrNull)
  final List<Photo>? photos;
  @JsonKey(name: 'place_id', fromJson: asOrNull)
  final String? placeId;
  @JsonKey(name: 'price_level', fromJson: asOrNull)
  final int? priceLevel;
  @JsonKey(name: 'rating', fromJson: asOrNull)
  final double? rating;
  @JsonKey(name: 'reference', fromJson: asOrNull)
  final String? reference;
  @JsonKey(name: 'types', fromJson: asOrNull)
  final List<String>? types;
  @JsonKey(name: 'user_ratings_total', fromJson: asOrNull)
  final int? userRatingsTotal;

  GoogleMapPlace(
    this.businessStatus,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.priceLevel,
    this.rating,
    this.reference,
    this.types,
    this.userRatingsTotal,
  );

  factory GoogleMapPlace.fromJson(Map<String, dynamic> json) =>
      _$GoogleMapPlaceFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleMapPlaceToJson(this);
}

@JsonSerializable()
class Geometry {
  final Location location;
  final Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });
  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable()
class Viewport {
  @JsonKey(name: 'northeast')
  final Location? northeast;
  @JsonKey(name: 'southwest')
  final Location? southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) =>
      _$ViewportFromJson(json);

  Map<String, dynamic> toJson() => _$ViewportToJson(this);
}

@JsonSerializable()
class OpeningHours {
  @JsonKey(name: 'open_now', fromJson: asOrNull)
  final bool? openNow;

  OpeningHours({this.openNow});

  factory OpeningHours.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursFromJson(json);

  Map<String, dynamic> toJson() => _$OpeningHoursToJson(this);
}

@JsonSerializable()
class Photo {
  @JsonKey(name: 'height', fromJson: asOrNull)
  final int? height;
  @JsonKey(name: 'width', fromJson: asOrNull)
  final int? width;
  @JsonKey(name: 'html_attributions', fromJson: asOrNull)
  final List<String>? htmlAttributions;
  @JsonKey(name: 'photo_reference', fromJson: asOrNull)
  final String? photoReference;

  Photo({
    this.height,
    this.width,
    this.htmlAttributions,
    this.photoReference,
  });
  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
