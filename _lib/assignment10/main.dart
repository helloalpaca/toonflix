/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

// Models
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

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const movieThumbUrl = "https://image.tmdb.org/t/p/w500/";
  final Future<List<MovieModel>> moviePopular =
      ApiService.getMoviePopularList();
  final Future<List<MovieModel>> movieNowPlaying =
      ApiService.getMovieNowPaying();
  final Future<List<MovieModel>> movieComingSoon =
      ApiService.getMovieComingSoon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Popular Movies",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: moviePopular,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                          height: 240, child: makePopularList(snapshot));
                    }
                    return const Text("No Movie");
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Now in Cinemas",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: movieNowPlaying,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                          height: 200, child: makeMovieList(snapshot));
                    }
                    return const Text("No Movie");
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Coming soon",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: movieComingSoon,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 200,
                        child: makeMovieList(snapshot),
                      );
                    }
                    return const Text("No Movie");
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView makePopularList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => DetailScreen(
                      id: snapshot.data![index].id,
                      posterPath: snapshot.data![index].poster_path,
                      title: snapshot.data![index].title,
                    )),
              ),
            );
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.network(
              movieThumbUrl + snapshot.data![index].poster_path,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              width: 320,
              height: 240,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 10,
        );
      },
    );
  }

  ListView makeMovieList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => DetailScreen(
                      id: snapshot.data![index].id,
                      posterPath: snapshot.data![index].poster_path,
                      title: snapshot.data![index].title,
                    )),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  movieThumbUrl + snapshot.data![index].poster_path,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                  height: 160,
                  width: 160,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 160,
                  child: Text(
                    snapshot.data![index].title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 10,
        );
      },
    );
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {super.key,
      required this.id,
      required this.posterPath,
      required this.title});
  final int id;
  final String posterPath, title;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  static const movieThumbUrl = "https://image.tmdb.org/t/p/w500/";

  late Future<MovieDetailModel> movieDetail;

  @override
  void initState() {
    super.initState();
    movieDetail = ApiService.getMovieDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          "Back to list",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("$movieThumbUrl${widget.posterPath}"),
            fit: BoxFit.fill,
            opacity: 0.8,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FutureBuilder(
                  future: movieDetail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Rating(value: snapshot.data!.vote_average),
                          Row(
                            children: [
                              for (var genre in snapshot.data!.genres)
                                Text(
                                  "${genre["name"]}, ",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            "Storyline",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            snapshot.data!.overview,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade500,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Buy Ticket",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Rating extends StatelessWidget {
  final num value;

  const Rating({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < value.toInt() ~/ 2) {
          return const Icon(
            Icons.star,
            color: Colors.yellow,
          );
        }
        if (index == value.toInt() ~/ 2 && value.toInt() % 2 == 1) {
          return const Icon(
            Icons.star_half,
            color: Colors.yellow,
          );
        } else {
          return Icon(Icons.star, color: Colors.black.withOpacity(0.6));
        }
      }),
    );
  }
}

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
*/