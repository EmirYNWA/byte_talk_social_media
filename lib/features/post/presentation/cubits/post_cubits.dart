import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/post/domain/repos/post_repo.dart';
import 'package:social_media_app/features/post/presentation/cubits/post_states.dart';
import 'package:social_media_app/features/storage/domain/storage_repo.dart';
import '../../domain/entities/post.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepo postRepo;
  final StorageRepo storageRepo;

  PostCubit({
    required this.postRepo,
    required this.storageRepo,}) : super(PostsInitial());

  Future<void> createPost(Post post, {String? imagePath, Uint8List? imageBytes}) async {
    String? imageUrl;

    try {
      if (imagePath != null){
        emit(PostsUpLoading());
        imageUrl = await storageRepo.uploadProfileImageMobile(imagePath, post.id);
      }
      else if (imageBytes != null){
        emit(PostsUpLoading());
        imageUrl = await storageRepo.uploadProfileImageMobile(imagePath!, post.id);
      }

      final newPost = post.copywith(imageUrl: imageUrl);
    } catch (e) {
      emit(PostsError('Failed to create post: $e'));
    }
  }

  Future<void> fetchAllPosts() async{
    try{
      emit(PostsLoading());
      final posts = await postRepo.fetchAllPosts();
      emit(PostsLoaded(posts));
    }catch(e){
      emit(PostsError('Failed to fetch posts: $e'));
    }
  }

  Future<void> deletePost(String postId) async{
    try{
      await postRepo.deletePost(postId);
    }catch(e){}
  }
}