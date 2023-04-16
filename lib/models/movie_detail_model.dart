class MovieDetailModel {
  final bool adult, video;
  final String? backdrop_path;
  final Map<String, dynamic>? belongs_to_collection;
  final String homepage, imdb_id, original_language, original_title, overview;
  final int budget, id, vote_count;
  final List<dynamic> genres;
  final num vote_average;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        video = json['video'],
        backdrop_path = json['backdrop_path'],
        belongs_to_collection = json['belongs_to_collection'],
        homepage = json['homepage'],
        imdb_id = json['imdb_id'],
        original_language = json['original_language'],
        original_title = json['original_title'],
        overview = json['overview'],
        budget = json['budget'],
        id = json['id'],
        vote_count = json['vote_count'],
        genres = json['genres'],
        vote_average = json['vote_average'];
}
