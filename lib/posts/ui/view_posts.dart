import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rest_api/constants/end_points.dart';
import 'package:rest_api/posts/model/posts_model.dart';

class ViewPostScreen extends StatefulWidget {
  const ViewPostScreen({super.key});

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  List<PostModel> postList = [];

  Future<List<PostModel>> getPostsResponse() async {
    final response = await http.get(Uri.parse(jsonPlaceholderUrl('posts')));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getPostsResponse(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text("Loading"));
              } else {
                return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(postList[index].id.toString()),
                      title: Text(postList[index].title.toString()),
                      subtitle: Text(postList[index].body.toString()),
                      trailing: Text(postList[index].userId.toString()),
                    );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
