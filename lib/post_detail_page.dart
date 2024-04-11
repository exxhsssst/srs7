import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:srs7/api_service.dart';

class PostDetailPage extends StatelessWidget {
  final ApiService apiService = ApiService(Dio());

  Future<Post> _fetchPost(int id) async {
    try {
      return await apiService.getPost(id);
    } catch (error) {
      throw Exception('Failed to load post: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final int postId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: FutureBuilder<Post>(
        future: _fetchPost(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: ${snapshot.data!.title}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Body: ${snapshot.data!.body}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
