import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:srs7/api_service.dart';
// ignore: unused_import
import 'package:srs7/post_detail_page.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final ApiService apiService = ApiService(Dio());

  Future<List<Post>> _fetchPosts() async {
    try {
      return await apiService.getPosts();
    } catch (error) {
      throw Exception('Failed to load posts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: _fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title ?? ''),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/post_detail',
                      arguments: snapshot.data![index].id,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
