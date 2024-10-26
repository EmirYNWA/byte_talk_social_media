import 'package:flutter/material.dart';
import 'package:social_media_app/features/chat/data/chat_service.dart';
import 'package:social_media_app/features/home/presentation/components/my_drawer.dart';
import '../../data/auth_service.dart';
import '../components/user_tile.dart';
import 'chat_page.dart';

class ChatListPage extends StatelessWidget {
  ChatListPage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats', style: TextStyle(fontFamily: 'Poppins'),),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),

      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text('Error', style: TextStyle(fontFamily: 'Poppins'),);
          }
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...', style: TextStyle(fontFamily: 'Poppins'),);
          }
          // list view
          return ListView(
            children: snapshot.data!.map<Widget>(
                    (userData) => _buildUserListItem(userData, context)
            ).toList(),
          );
        }
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    // display all users except the current one
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          // tapped on a user => go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverEmail: userData['email'],
                    receiverID: userData['uid'],
                  )
              )
          );
        },
      );
    }
    else {
      return Container();
    }
  }
}
