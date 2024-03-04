import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/comments/model.dart';
import 'package:rest_api/constants/end_points.dart';

class ViewCommentsScreen extends StatefulWidget {
  const ViewCommentsScreen({super.key});

  @override
  State<ViewCommentsScreen> createState() => _ViewCommentsScreenState();
}

class _ViewCommentsScreenState extends State<ViewCommentsScreen> {
  List<CommentModel> commentList = [];

  Future<List<CommentModel>> getCommentResponse() async {
    final response = await http.get(Uri.parse(jsonPlaceholderUrl('comments')));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        commentList.add(CommentModel.fromJson(i));
      }
      return commentList;
    } else {
      return commentList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getCommentResponse(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child:  Text("Loading"));
              } else {
                return ListView.builder(
                  itemCount: commentList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(commentList[index].id.toString()),
                      title: Text(commentList[index].email.toString()),
                      subtitle: Text(commentList[index].body.toString()),
                      trailing: Text(commentList[index].postId.toString()),
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
