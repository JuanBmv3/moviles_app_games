import 'package:app_juegos/models/games_model.dart';
import 'package:app_juegos/network/api_games.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TopGamesScreen extends StatefulWidget {
  TopGamesScreen({Key? key}) : super(key: key);

  @override
  _TopGamesScreenState createState() => _TopGamesScreenState();
}

class _TopGamesScreenState extends State<TopGamesScreen> {

  ApiGames? api_games;
  @override
  void initState() {
    // TODO: implement initState
    api_games = ApiGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topLeft,
          child: Text("BEST VIDEO GAMES",
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
      ],
    );
  }

  Widget ListGames() {
    return FutureBuilder(
        future: api_games!.getAllTop(),
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
   return  ListView.separated(
        itemBuilder: (context,index){
          GamesModel games = data![index];
         return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0.0,5.0),
            blurRadius: 2.5
          )
        ]
      ) ,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children:[
            Container(
              child: FadeInImage(
                placeholder: AssetImage('assets/loading.gif'), 
                image: NetworkImage(games.backgroundImage == null ? 'https://1.bp.blogspot.com/-7NqsY6kkUE0/V1CohGECLiI/AAAAAAAAAQw/eYszPqQmy-Q8hqnfROjlk0DFPmoS44-RACLcB/s1600/new%2B%25282%2529.png': games.backgroundImage!),
                fadeInDuration: Duration(milliseconds: 500),
                fit: BoxFit.cover,
              )
            ),
            Opacity(
              opacity: .8,
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                height: 55.0,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(games.name!, style: TextStyle(color: Colors.white, fontSize:12.0, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text('${games.metacritic!.toString()}% - Metacritic', style: TextStyle(color: Colors.red, fontSize:18.0, fontWeight: FontWeight.bold)),
                    ),
                   
                  ],
                )
              ),
            )
          ]
        ),
      ),
    );
          
        }, 
        separatorBuilder: (_,__) => Divider(height:10), 
        itemCount: data!.length,
      );
  }
}