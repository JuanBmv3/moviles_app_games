import 'package:app_juegos/models/games_model.dart';
import 'package:app_juegos/network/api_games.dart';
import 'package:app_juegos/screens/views/CarrGames.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListGamesScreen extends StatefulWidget {
  ListGamesScreen({Key? key}) : super(key: key);

  @override
  _ListGamesScreenState createState() => _ListGamesScreenState();
}

class _ListGamesScreenState extends State<ListGamesScreen> {
  ApiGames? api_games;

  @override
  void initState() {
    // TODO: implement initState
    api_games = ApiGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SliderGames(),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topLeft,
          child: Text("LATEST GAMES LIST",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              )),
        ),
      ),
      Expanded(
        child: ListGames(),
      ),
    ]);
  }

  Widget ListGames() {
    return FutureBuilder(
        future: api_games!.getAll(),
        builder: (context, AsyncSnapshot<List<GamesModel>?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Hay un error en la petición'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return listOfGames(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          }
        });
  }

  Widget listOfGames(List<GamesModel>? data) {
    return AnimationLimiter(

        child: GridView.count(
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.75,
          crossAxisCount: 3,
          children: List.generate(
            data!.length,
            (int index) {
              GamesModel game = data[index];

              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 3,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/detail', arguments: {
                          'background_image': game.backgroundImage,
                          'name': game.name,
                          'id': game.id,
                          'released': game.released,
                          'rating': game.rating,
                          'metacritic': game.metacritic,
                          
                          
                        });
                      },
                      child: Stack(
                        children: [
                          Hero(
                            tag: game.id!,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(game.backgroundImage!),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.8),
                                        Colors.black.withOpacity(0.0)
                                      ],
                                      stops: [
                                        0.0,
                                        0.5
                                      ])),
                            ),
                          ),
                          Positioned(
                            bottom: 20.0,
                            left: 5.0,
                            child: Container(
                              width: 90.0,
                              child: Text(
                                game.name!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5.0,
                            left: 5.0,
                            child: Row(
                              children: [
                                RatingBar.builder(
                                  itemSize: 10,
                                  initialRating: game.rating! / 2,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                SizedBox(
                                  width: 3.0,
                                ),
                                Text(
                                  (game.rating).toString().substring(0, 3),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
    );
  }
}
