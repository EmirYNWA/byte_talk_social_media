import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/presentaion/cubits/auth_cubit.dart';
import '../../../chat/presentation/pages/chat_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> emails = [];
  List<String> filteredEmails = [];
  String? loggedInUserEmail;

  @override
  void initState() {
    super.initState();
    loggedInUserEmail = BlocProvider.of<AuthCubit>(context).currentUser?.email;
    _getEmailsFromFirestore();
  }

  void _getEmailsFromFirestore() async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await usersCollection.get();

    List<String> fetchedEmails = querySnapshot.docs
        .map((doc) => doc['email'] as String)
        .where((email) => email != loggedInUserEmail)
        .toList();

    setState(() {
      emails = fetchedEmails;
      filteredEmails = emails.take(5).toList();
    });
  }

  void searchEmails(String query) {
    final suggestions = emails.where((email) {
      return email.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredEmails = suggestions.take(5).toList();
    });
  }

  void _navigateToChat(String email) async {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await usersCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      final userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
      final receiverID = userData['uid'] as String;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            receiverEmail: email,
            receiverID: receiverID,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: const Icon(Icons.search, color: Colors.black),
                        suffixIcon: searchController.text.isEmpty
                            ? null
                            : IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.black),
                          onPressed: () {
                            searchController.clear();
                            searchEmails('');
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onChanged: searchEmails,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredEmails.length,
                itemBuilder: (context, index) {
                  final email = filteredEmails[index];
                  return ListTile(
                    title: Text(email),
                    onTap: () {
                      _navigateToChat(email);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
