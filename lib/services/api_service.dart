import 'dart:convert';

import 'package:toonflix/models/movie_detail_model.dart';
import 'package:toonflix/models/movie_popular_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const moviePopularUrl =
      "https://movies-api.nomadcoders.workers.dev/popular";
  static const movieNowPlayingUrl =
      "https://movies-api.nomadcoders.workers.dev/now-playing";
  static const movieComingSoonUrl =
      "https://movies-api.nomadcoders.workers.dev/coming-soon";
  static const movieDetailUrl =
      "https://movies-api.nomadcoders.workers.dev/movie";

  static Future<List<MovieModel>> getMoviePopularList() async {
    return getMovieByUrl(moviePopularUrl);
  }

  static Future<List<MovieModel>> getMovieNowPaying() async {
    return getMovieByUrl(movieNowPlayingUrl);
  }

  static Future<List<MovieModel>> getMovieComingSoon() async {
    return getMovieByUrl(movieComingSoonUrl);
  }

  static Future<List<MovieModel>> getMovieByUrl(String strUrl) async {
    final List<MovieModel> movieInstances = [];
    final url = Uri.parse(strUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final results = json['results'];
      for (var movie in results) {
        var movieInstance = MovieModel.fromJson(movie);
        movieInstances.add(movieInstance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieDetail(int id) async {
    final url = Uri.parse("$movieDetailUrl?id=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final MovieDetailModel movieDetailModel = MovieDetailModel.fromJson(json);
      return movieDetailModel;
    }
    throw Error();
  }
}
