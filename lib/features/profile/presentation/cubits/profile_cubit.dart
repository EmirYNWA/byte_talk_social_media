
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/repos/profile_repo.dart';
import 'package:social_media_app/features/profile/presentation/cubits/profile_states.dart';

class ProfileCubit extends Cubit<ProfileState>{
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super (ProfileInitial());

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

  // update bio and or profile picutre
  Future<void> updateProfile({
    required String uid,
    String? newBio,
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

      //update new profile
      final updatedProfile = currenUser.copyWith(newBio:newBio ?? currenUser.bio);

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