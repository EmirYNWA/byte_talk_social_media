import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/post/domain/repos/post_repo.dart';

import 'package:social_media_app/features/post/domain/entities/post.dart';

class FirebasePostRepo implements PostRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> createPost(Post post) async {
    try{
      await postCollection.doc(post.id).set(post.toJson());
    }catch(e){
      throw Exception('Error creating post: $e');
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    await postCollection.doc(postId).delete();
  }

  @override
  Future<List<Post>> fetchAllPosts() async {
    try{
      final postsSnapshot = await postCollection.orderBy('timestamp', descending: true).get();

      final List<Post> allPosts = postsSnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>)).toList();
      return allPosts;
    }catch(e){
      throw Exception('Error fetching posts: $e');
    }
  }

  @override
  Future<List<Post>> fetchPostsByUserId(String userId) async{
    try{

      final postsSnapshot = await postCollection.where('userId', isEqualTo: userId).get();
      final userPosts = postsSnapshot.docs.map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>)).toList();

      return userPosts;
    }catch(e){
      throw Exception('Error fetching posts by user: $e');
    }
  }

  @override
  Future<void> toggleLikePost(String postId, String userId) async {
    try{
      // get the post document from firestore
      final postDoc = await postCollection.doc(postId).get();
      
      if(postDoc.exists){
        final post = Post.fromJson(postDoc.data() as Map<String, dynamic>);

        // check if user has already like this post
        final hasLiked = post.likes.contains(userId);

        //update the likes list
        if(hasLiked){
          post.likes.remove(userId); // unlike
        }
        else{
          post.likes.add(userId); // like
        }

        // update the post document with the new like list
        await postCollection.doc(postId).update({
          'likes': post.likes,
        });
      }
      else{
        throw Exception("Post not found");
      }
    }
    catch(e){
        throw Exception("Error toggling like: $e");
    }
  }
}