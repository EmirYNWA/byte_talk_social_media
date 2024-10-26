import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/repos/profile_repo.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_states.dart';
import '../../../storage/domain/storage_repo.dart';
import '../../domain/entities/profile_user.dart';

class ProfileCubit extends Cubit<ProfileState>{
  final ProfileRepo profileRepo;
  final StorageRepo storageRepo;

  ProfileCubit({
    required this.profileRepo,
    required this.storageRepo,
  }) : super (ProfileInitial());

  //fetch user profile using repo
  Future<void> fetchUserProfile(String uid) async{
    try{
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);

      if(user != null){
        emit(ProfileLoaded(user));
      }else{
        emit(ProfileError("User not found"));
      }
    }

    catch(e){
      emit(ProfileError(e.toString()));
    }
  }

  Future<ProfileUser?> getUserProfile(String uid) async {
    final user = await profileRepo.fetchUserProfile(uid);
    return user;
  }

  // update bio and or profile picutre
  Future<void> updateProfile({
    required String uid,
    String? newBio,
    Uint8List? imageWebBytes,
    String? imageMobilePath,

  }) async {
  emit(ProfileLoading());

    try{
      //fetch current profile first
      final currenUser = await profileRepo.fetchUserProfile(uid);

      if(currenUser==null){
        emit(ProfileError("Failed to fetch user for profile update"));
        return;
      }

      //profile picutre update
      String? imageDownloadUrl;
      if (imageWebBytes != null || imageMobilePath != null) {
        // for mobile
        if (imageMobilePath != null) {
          imageDownloadUrl = await storageRepo.uploadProfileImageMobile(imageMobilePath, uid);
        }
        // for web
        else if (imageWebBytes != null) {
          imageDownloadUrl = await storageRepo.uploadProfileImageWeb(imageWebBytes, uid);
        }

        if (imageDownloadUrl == null) {
          emit(ProfileError('Failed to upload an image'));
          return;
        }
      }

      //update new profile
      final updatedProfile = currenUser.copyWith(
        newBio:newBio ?? currenUser.bio,
        newProfileImageUrl: imageDownloadUrl ?? currenUser.profileImageUrl,
      );

      //update in repo
      await profileRepo.updateProfile(updatedProfile);

      //refetch the updated profile
      await fetchUserProfile(uid);
    }

    catch(e){
      emit(ProfileError("Error updating profile: $e"));
    }
  }
}