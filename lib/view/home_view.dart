import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdbnetflix/viewmodel/movie_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final MovieViewModel _movieViewModel = Get.put(MovieViewModel());

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceheight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(6, 6, 6, 1),
          centerTitle: true,
          title: Image.asset(
            "assets/images/applogo.png",
            fit: BoxFit.contain,
            height: 32,
          ),
          leading: const Icon(Icons.menu),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            )
          ],
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Top Rated",
                style: GoogleFonts.openSans(fontSize: 18),
              ),
              episodeList(deviceWidth, deviceheight),
              Text(
                "Trending Now",
                style: GoogleFonts.openSans(fontSize: 18),
              ),
              episodeList(deviceWidth, deviceheight),
              Text(
                "Watch it again",
                style: GoogleFonts.openSans(fontSize: 18),
              ),
              episodeList(deviceWidth, deviceheight),
            ],
          ),
        ));
  }

  Expanded episodeList(double deviceWidth, double deviceheight) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: _movieViewModel.topRatedList?.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: SizedBox(
                width: deviceWidth * 0.3,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500/${_movieViewModel.topRatedList?[index].posterPath}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                      child: Container(
                    width: deviceWidth * 0.8,
                    height: deviceheight * 0.7,
                    color: Color.fromRGBO(24, 24, 24, 1),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              child: Stack(
                            children: [
                              ShaderMask(
                                shaderCallback: (rect) {
                                  return const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.black, Colors.transparent],
                                  ).createShader(Rect.fromLTRB(
                                      0, 0, rect.width, rect.height));
                                },
                                blendMode: BlendMode.dstIn,
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500/${_movieViewModel.topRatedList?[index].backdropPath}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    child: const CircleAvatar(
                                        maxRadius: 15,
                                        child: Icon(
                                          Icons.close,
                                          size: 15,
                                        )),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  )),
                              Positioned(
                                bottom: deviceheight * 0.0125,
                                left: deviceWidth * 0.025,
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white),
                                        onPressed: () {},
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.play_arrow,
                                                color: Colors.black),
                                            Text(
                                              "Play",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        )),
                                    const Icon(CupertinoIcons.add_circled),
                                    const Icon(CupertinoIcons.heart_circle),
                                  ],
                                ),
                              )
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _movieViewModel
                                              .topRatedList?[index].voteAverage
                                              .toString() ??
                                          "",
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: SizedBox(
                                          child: Text(
                                            _movieViewModel.topRatedList?[index]
                                                    .overview ??
                                                "",
                                            style:
                                                const TextStyle(fontSize: 10),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: SizedBox(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Popularity: ${_movieViewModel.topRatedList?[index].popularity}",
                                                    style: const TextStyle(
                                                        fontSize: 10)),
                                                Text(
                                                    "Vote Count: ${_movieViewModel.topRatedList?[index].voteCount}",
                                                    style: const TextStyle(
                                                        fontSize: 10)),
                                                Text(
                                                    "First air date: ${_movieViewModel.topRatedList?[index].firstAirDate}",
                                                    style: const TextStyle(
                                                        fontSize: 10)),
                                              ]),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          )
                        ]),
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
