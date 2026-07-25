import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/post_model.dart';

abstract class FeedLocalDataSource {
  Future<List<PostModel>> getPosts();
}

class FeedLocalDataSourceImpl implements FeedLocalDataSource {
  @override
  Future<List<PostModel>> getPosts() async {
    final jsonString =
    await rootBundle.loadString('assets/json/posts_data.json');

    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList
        .map((e) => PostModel.fromJson(e))
        .toList();
  }
}