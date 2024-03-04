import 'package:flutter/material.dart';
import 'package:rest_api/comments/view_comments_screen.dart';
import 'package:rest_api/posts/ui/view_posts.dart';
import 'package:rest_api/users/view_users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rest API"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ViewPostScreen();
                      },
                    ));
                  },
                  child: const Text("Posts")), 
                  const SizedBox(height: 20),
                  ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ViewCommentsScreen();
                      },
                    ));
                  },
                  child: const Text("Comments")), 
                  const SizedBox(height: 20),
                  ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ViewUsersScreen();
                      },
                    ));
                  },
                  child: const Text("Users"))
            ],
          ),
        ));
  }
}
