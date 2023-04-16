class MovieModel {
  final bool adult, video;
  final String? backdrop_path;
  final String original_language,
      original_title,
      overview,
      poster_path,
      release_date,
      title;
  final List<dynamic> genre_ids;
  final int id, vote_count;
  final double popularity;
  final num vote_average;

  MovieModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        video = json['video'],
        backdrop_path = json['backdrop_path'],
        original_language = json['original_language'],
        original_title = json['original_title'],
        overview = json['overview'],
        poster_path = json['poster_path'],
        release_date = json['release_date'],
        title = json['title'],
        genre_ids = json['genre_ids'],
        id = json['id'],
        vote_count = json['vote_count'],
        popularity = json['popularity'],
        vote_average = json['vote_average'];
}
