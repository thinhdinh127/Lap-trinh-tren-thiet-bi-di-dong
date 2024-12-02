
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {"title": "Bài viết 1", "description": "Mô tả ngắn gọn về bài viết 1"},
    {"title": "Bài viết 2", "description": "Mô tả ngắn gọn về bài viết 2"},
    {"title": "Bài viết 3", "description": "Mô tả ngắn gọn về bài viết 3"},
    {"title": "Bài viết 4", "description": "Mô tả ngắn gọn về bài viết 4"},
    {"title": "Bài viết 5", "description": "Mô tả ngắn gọn về bài viết 5"},
    {"title": "Bài viết 6", "description": "Mô tả ngắn gọn về bài viết 6"},
    {"title": "Bài viết 7", "description": "Mô tả ngắn gọn về bài viết 7"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang chủ'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: Image.network(
                'https://picsum.photos/200/200', // Thay bằng URL ảnh thực tế
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(articles[index]['title']!),
              subtitle: Text(articles[index]['description']!),
            ),
          );
        },
      ),
    );
  }
}