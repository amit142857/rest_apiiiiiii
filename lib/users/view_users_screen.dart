import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rest_api/constants/end_points.dart';
import 'package:rest_api/users/model.dart';
import 'package:http/http.dart' as http;

class ViewUsersScreen extends StatefulWidget {
  const ViewUsersScreen({super.key});

  @override
  State<ViewUsersScreen> createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {
  List<UsersModel> userList = [];
  Future<List<UsersModel>> getUsersResponse() async {
    final response = await http.get(Uri.parse(jsonPlaceholderUrl('users')));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userList.add(UsersModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUsersResponse(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("Loading"),
                );
              } else {
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(userList[index].id.toString()),
                      title: Text(userList[index].name.toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userList[index].username.toString()),
                          Text(userList[index].phone.toString()),
                          Text(userList[index].website.toString()),
                          Text(userList[index].email.toString()),
                          Text(userList[index].company?.name.toString() ?? ''),
                          Text(userList[index].address?.city.toString() ?? ''),
                          Text(userList[index].address?.geo?.lng.toString() ??
                              ''),
                          Text(userList[index].address?.geo?.lat.toString() ??
                              ''),
                          Text(userList[index].address?.zipcode ?? ""),
                        ],
                      ),
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
