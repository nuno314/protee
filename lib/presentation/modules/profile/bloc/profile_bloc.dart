import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';

import '../../../../common/services/upload_service.dart';
import '../../../../data/models/user.dart';
import '../../../../di/di.dart';
import '../../../base/base.dart';
import '../interactor/profile_interactor.dart';
import '../repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends AppBlocBase<ProfileEvent, ProfileState> {
  late final _uploadService = injector.get<UploadService>();

  late final _interactor = ProfileInteractorImpl(
    ProfileRepositoryImpl(),
  );

  ProfileBloc() : super(ProfileInitial(viewModel: const _ViewModel())) {
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
  }

  Future<void> _onUpdateProfileEvent(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    var user = event.user;
    if (event.avatar != null) {
      final url = await _uploadProfilePictures(event.avatar!);
      user = user.copyWith(avatar: url);
    }
    final res = await _interactor.updateProfile(user);

    if (res) {
      emit(state.copyWith<ProfileUpdated>());
    }
  }

  Future<String?> _uploadProfilePictures(File avatar) async {
    return _uploadService.uploadFile(
      avatar,
      uploadFolder: UploadService.userProfilePath,
    );
  }
}
