// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: asOrNull(json['id']),
      countryCode: asOrNull(json['country_code']),
      districtCode: asOrNull(json['district_code']),
      districtName: asOrNull(json['district_name']),
      provinceCode: asOrNull(json['province_code']),
      provinceName: asOrNull(json['province_name']),
      wardCode: asOrNull(json['ward_code']),
      wardName: asOrNull(json['ward_name']),
      street: asOrNull(json['street']),
      addressName: asOrNull(json['address_name']),
      contactName: asOrNull(json['contact_name']),
      phoneNumber: asOrNull(json['phone_number']),
      phoneCode: asOrNull(json['phone_code']),
      type: asOrNull(json['type']),
      position: json['position'] == null
          ? null
          : Position.fromJson(json['position'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'country_code': instance.countryCode,
      'district_code': instance.districtCode,
      'district_name': instance.districtName,
      'province_code': instance.provinceCode,
      'province_name': instance.provinceName,
      'ward_code': instance.wardCode,
      'ward_name': instance.wardName,
      'street': instance.street,
      'address_name': instance.addressName,
      'contact_name': instance.contactName,
      'phone_number': instance.phoneNumber,
      'phone_code': instance.phoneCode,
      'type': instance.type,
      'position': instance.position?.toJson(),
    };
