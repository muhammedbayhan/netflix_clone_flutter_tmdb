import 'package:dio/dio.dart';

import '../model/movie_model.dart';

class MovieService {
  Future<List<MovieModel>?> fetchTopRated() async {
    final response = await Dio().get(
        "https://api.themoviedb.org/3/tv/top_rated",
        options: Options(headers: {
          "Authorization": "API KEY",
          "accept": "application/json"
        }));

    if (response.statusCode == 200) {
      final datas = response.data["results"];
      if (datas is List) {
        return datas.map((e) => MovieModel.fromJson(e)).toList();
      }
    }
    return null;
  }
}
