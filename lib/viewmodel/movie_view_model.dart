import 'package:get/get.dart';

import '../model/movie_model.dart';
import '../service/movie_service.dart';

class MovieViewModel extends GetxController {
  final MovieService _movieService = MovieService();
  RxList<MovieModel>? topRatedList = <MovieModel>[].obs;

  Future<void> topRated() async {
    try {
      List<MovieModel>? fetchedMovies = await _movieService.fetchTopRated();
      if (fetchedMovies != null) {
        topRatedList!.assignAll(fetchedMovies);
        print(topRatedList?.length);
      } else {}
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void onInit() {
    topRated();

    super.onInit();
  }
}
