// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:json_annotation/json_annotation.dart';

import '../../common/utils.dart';
import '../../common/utils/data_checker.dart';
import 'location.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  @JsonKey(name: 'id', fromJson: asOrNull)
  String? id;
  @JsonKey(name: 'country_code', fromJson: asOrNull)
  String? countryCode;
  @JsonKey(name: 'district_code', fromJson: asOrNull)
  String? districtCode;
  @JsonKey(name: 'district_name', fromJson: asOrNull)
  String? districtName;
  @JsonKey(name: 'province_code', fromJson: asOrNull)
  String? provinceCode;
  @JsonKey(name: 'province_name', fromJson: asOrNull)
  String? provinceName;
  @JsonKey(name: 'ward_code', fromJson: asOrNull)
  String? wardCode;
  @JsonKey(name: 'ward_name', fromJson: asOrNull)
  String? wardName;
  @JsonKey(name: 'street', fromJson: asOrNull)
  String? street;
  @JsonKey(name: 'address_name', fromJson: asOrNull)
  String? addressName;
  @JsonKey(name: 'contact_name', fromJson: asOrNull)
  String? contactName;
  @JsonKey(name: 'phone_number', fromJson: asOrNull)
  String? phoneNumber;
  @JsonKey(name: 'phone_code', fromJson: asOrNull)
  int? phoneCode;
  @JsonKey(name: 'type', fromJson: asOrNull)
  String? type;
  @JsonKey(name: 'position')
  Position? position;

  Address({
    this.id,
    this.countryCode,
    this.districtCode,
    this.districtName,
    this.provinceCode,
    this.provinceName,
    this.wardCode,
    this.wardName,
    this.street,
    this.addressName,
    this.contactName,
    this.phoneNumber,
    this.phoneCode,
    this.type,
    this.position,
  });

  bool get valid => [
        street,
        districtName,
        provinceName,
      ].every((element) => element.isNotNullOrEmpty);

  String get fullAddressDescription {
    return [street, wardName, districtName, provinceName]
        .where((element) => element != null && element.isNotEmpty == true)
        .join(', ');
  }

  String get fullAddressDescriptionWithAddressName {
    return '''$addressName - ${[
      street,
      wardName,
      districtName,
      provinceName
    ].where((element) => element != null && element.isNotEmpty == true).join(', ')}''';
  }

  String get shortAddressDescription {
    return [street, wardName, districtName]
        .where((element) => element != null && element.isNotEmpty == true)
        .join(', ');
  }

  Future<List<double>?> get getLocationFromAddress async {
    try {
      final locations =
          await geocoding.locationFromAddress(fullAddressDescription);
      final location = locations.firstOrNull;
      if (location == null) {
        return null;
      }
      return [
        location.longitude,
        location.latitude,
      ];
    } catch (e) {
      return null;
    }
  }

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

class AddressRequest {
  String? accountId;
  final String? countryCode;
  final String? districtCode;
  final String? districtName;
  final String? provinceCode;
  final String? provinceName;
  final String? wardCode;
  final String? wardName;
  final String? street;

  AddressRequest({
    this.accountId,
    required this.countryCode,
    required this.districtCode,
    required this.districtName,
    required this.provinceCode,
    required this.provinceName,
    required this.wardCode,
    required this.wardName,
    required this.street,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'country_code': countryCode,
      'district_code': districtCode,
      'district_name': districtName,
      'province_code': provinceCode,
      'province_name': provinceName,
      'ward_code': wardCode,
      'ward_name': wardName,
      'street': street,
    };
  }
}
