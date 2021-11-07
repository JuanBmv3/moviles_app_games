import 'dart:async';

import 'package:app_juegos/models/games_model.dart';
import 'package:app_juegos/network/api_games.dart';
import 'package:app_juegos/utils/colors_settings.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

class SliderGames extends StatefulWidget {
  SliderGames({Key? key}) : super(key: key);

  @override
  _SliderGamesState createState() => _SliderGamesState();
}

class _SliderGamesState extends State<SliderGames> {

  ApiGames? api_games;
  final PageController controller = PageController(initialPage: 0);
   int _currentPage = 0;
   bool end = false;


  @override
  void initState() {
    // TODO: implement initState
    api_games = ApiGames();
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
    if (_currentPage < 6) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }

   controller.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  });
    

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: api_games!.getAll(),
        builder: (context, AsyncSnapshot<List<GamesModel>?> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text('Hay un error en la petición'),);
              
            }else{
              if(snapshot.connectionState == ConnectionState.done){
              
                return _listGames(snapshot.data);
              }else{
                return CircularProgressIndicator();
                
              }
            }
        }
      );
  }

  Widget _listGames(List<GamesModel>? data) {
   
     return Container(
       height: 200,
       child: PageIndicatorContainer(
         align: IndicatorAlign.bottom,
         length: 5,
         indicatorSpace: 10.0,
         padding: EdgeInsets.all(3.0),
         indicatorColor: Colors.white,
         shape: IndicatorShape.circle(size: 8),
         indicatorSelectorColor: Colors.blue,
         child: PageView.builder(

            scrollDirection: Axis.horizontal,
            itemBuilder:(context,index){
              GamesModel game = data![index];
              
              
              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(game.backgroundImage!),
                        fit: BoxFit.cover
                      ),
                    ), 
                  ),
                  SizedBox(
                      height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        stops: [
                          0.1,
                          0.9
                        ],
                        colors:[
                          Colors.black.withOpacity(.8),
                          Colors.black.withOpacity(.1)
                         ]
                      )
                    )
                  ),
                  Positioned(
                    left: 8.0,
                    bottom: 16.0,
                    child: Container(
                      height: 100.0,
                      child: AspectRatio(
                        aspectRatio: 1.3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            image: DecorationImage(
                              image: NetworkImage(game.backgroundImage!),
                              fit: BoxFit.cover
                            )
                          )
                        ),
                      )
                    )
                  ),
                  Positioned(
                    left: 150,
                    bottom: 50,
                    child: Text(game.name!, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  )
                ],
              );
            } ,
            controller: controller,
            itemCount: 5,
          ),
         

       ),
     );

  }
}