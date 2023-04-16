import 'package:flutter/material.dart';
import 'package:toonflix/models/movie_popular_model.dart';
import 'package:toonflix/screens/detail_screen.dart';
import 'package:toonflix/services/api_service.dart';

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

//
//                Text(snapshot.data![index].title),/