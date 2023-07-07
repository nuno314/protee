import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../models/family.dart';
import '../../../models/location.dart';
import '../../../models/notification_model.dart';
import '../../../models/response.dart';
import '../../../models/user.dart';
import 'api_contract.dart';

part 'rest_api_repository.g.dart';

///////////////////////////////////////////////////////////////////////
//                https://pub.dev/packages/retrofit                 //
// flutter pub run build_runner build --delete-conflicting-outputs //
////////////////////////////////////////////////////////////////////

@RestApi()
abstract class RestApiRepository {
  factory RestApiRepository(Dio dio, {String baseUrl}) = _RestApiRepository;

  @POST(ApiContract.socialRegiser)
  Future<AuthResponse?> registerByEmail({
    @Field('firebaseToken') String token = '',
  });

  // Family
  @GET(ApiContract.getInviteCode)
  Future<CodeResponse?> getInviteCode();

  @POST(ApiContract.joinFamily)
  Future<BooleanResponse?> joinFamily({
    @Field('code') required String code,
  });

  @GET(ApiContract.getFamilyProfile)
  Future<Family?> getFamilyProfile();

  @GET(ApiContract.getFamilyMembers)
  Future<List<UserFamily>?> getFamilyMembers();

  @POST(ApiContract.refreshToken)
  Future<AuthResponse> refreshToken(
    @Field('refreshToken') String refreshToken,
  );

  @POST(ApiContract.location)
  Future<UserLocation> addLocation({
    @Field('name') required String name,
    @Field('description') required String description,
    @Field('lat') required double lat,
    @Field('long') required double lng,
  });

  @GET(ApiContract.locationUser)
  Future<List<UserLocation>> getLocation();

  @GET(ApiContract.profile)
  Future<User?> getUserProfile();

  @GET(ApiContract.joinFamilyRequests)
  Future<List<JoinFamilyRequest>> getJoinFamilyRequests();

  @PUT(ApiContract.profile)
  Future<User?> updateProfile({
    @Field('name') String? name,
    @Field('phoneNumber') String? phoneNumber,
    @Field('email') String? email,
    @Field('dob') String? dob,
    @Field('avt') String? avatar,
  });

  @POST(ApiContract.locationNearby)
  Future<List<UserLocation>> getLocationNearby({
    @Field('lat') required double lat,
    @Field('long') required double lng,
  });

  @POST(ApiContract.removeMember)
  Future<BooleanResponse?> removeMember({
    @Field('memberId') required String id,
  });

  @POST(ApiContract.leaveFamily)
  Future<User?> leaveFamily();

  @POST(ApiContract.approveJoinRequest)
  Future<BooleanResponse?> approveJoinRequest({
    @Field('requestId') required String id,
  });

  @POST(ApiContract.rejectJoinRequest)
  Future<BooleanResponse?> rejectJoinRequest({
    @Field('requestId') required String id,
  });

  @POST(ApiContract.removeLocation)
  Future<BooleanResponse?> removeLocation({
    @Field('locationId') required String id,
  });

  @GET(ApiContract.messages)
  Future<MessageResponse?> getMessages({
    @Query('page') required int page,
    @Query('take') required int take,
  });

  @POST(ApiContract.sendMessage)
  Future<dynamic> sendMessage({
    @Field('content') required String message,
  });

  @GET(ApiContract.basicInformation)
  Future<FamilyStatistic?> getBasicInformation();

  @GET(ApiContract.locationHistory)
  Future<LocationResponse> getLocationHistory({
    @Query('userId') required String userId,
    @Query('fromDate') String? from,
    @Query('toDate') String? to,
    @Query('page') required int page,
    @Query('take') required int take,
  });

  @GET(ApiContract.lastLocation)
  Future<LatestLocationResponse?> getLastLocation(
    @Path('userId') String userId,
  );

  @GET(ApiContract.notification)
  Future<NotificationResponse?> getNotification({
    @Query('page') required int page,
    @Query('take') required int take,
  });

  @POST(ApiContract.readNotification)
  Future<NotificationModel?> readNotification(
    @Path('id') String id,
  );

  @POST(ApiContract.readAllNotification)
  Future<BooleanResponse?> readAllNotifications();

  @PUT(ApiContract.updateChild)
  Future<UserFamily?> updateChild({
    @Field('memberId') String? id,
  });

  @PUT(ApiContract.updateParent)
  Future<UserFamily?> updateParent({
    @Field('memberId') String? id,
  });
}
