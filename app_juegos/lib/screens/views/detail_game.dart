import 'dart:ui';

import 'package:app_juegos/models/desc_game_model.dart';
import 'package:app_juegos/models/games_model.dart';
import 'package:app_juegos/models/images_game_model.dart';
import 'package:app_juegos/network/api_games.dart';
import 'package:app_juegos/utils/colors_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:page_indicator/page_indicator.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ApiGames? api_games;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    api_games = ApiGames();
    controller =  PageController();
  }

  @override
  Widget build(BuildContext context) {
    final game =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;


    return Scaffold(
        backgroundColor: Colores.backgroundColor,
        body: ListView(shrinkWrap: true, children: [
          portada(game['background_image'], game['name'], game['id']),
          desc(game['id']),
          info(game['released'], game['rating'], game['metacritic']),
          screenshots(game['id'])
        ]));
  }

  Widget portada(image, name, id) {
    return Container(
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            child: Hero(
              tag: id,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image == null
                          ? 'https://1.bp.blogspot.com/-7NqsY6kkUE0/V1CohGECLiI/AAAAAAAAAQw/eYszPqQmy-Q8hqnfROjlk0DFPmoS44-RACLcB/s1600/new%2B%25282%2529.png'
                          : image),
                      fit: BoxFit.cover),
                ),
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
                      end: Alignment.centerLeft,
                      stops: [
                0.1,
                0.10
              ],
                      colors: [
                Colors.black.withOpacity(.1),
                Colors.black.withOpacity(.1)
              ]))),
          Positioned(
              left: 8.0,
              bottom: 16.0,
              child: Container(
                  height: 100.0,
                  child: AspectRatio(
                    aspectRatio: 1.3,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            image: DecorationImage(
                                image: NetworkImage(image == null
                                    ? 'http://lenguayliteratura.org/proyectoaula/wp-content/uploads/2016/02/no-logo.jpg'
                                    : image),
                                fit: BoxFit.cover))),
                  ))),
          Positioned(
            left: 150,
            bottom: 50,
            child: Text(name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget desc(id) {
    return FutureBuilder(
        future: api_games!.getDesc(id),
        builder: (context, AsyncSnapshot<DescModel?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Hay un error en la petición'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              final desc = snapshot.data;
              return ListView(shrinkWrap: true, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "SUMMARY",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    desc!.descriptionRaw!,
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                )
              ]);
            } else {
              return Container();
            }
          }
        });
  }

  Widget info(released, rating, metacritic,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
          child: Text(
            "RELEASED".toUpperCase(),
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10.0, bottom: 10.0),
          child: Text(
            released,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15.0, ),
          child: Text(
            "RATING".toUpperCase(),
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RatingBar.builder(
                itemSize: 20,
                initialRating: rating/2 ,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
            SizedBox(
              width: 3.0,
            ),
            Text(
              (rating).toString().substring(0, 3),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )
          ],
          
        ),
         Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15.0, ),
          child: Text(
            "METACRITIC".toUpperCase(),
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10.0, bottom: 10.0),
          child: Text(
            metacritic.toString(),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15.0, ),
          child: Text(
            "SCREENSHOTS".toUpperCase(),
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
       
        
        
      ],
    );
  }

  Widget screenshots(id) {
    return FutureBuilder(
        future: api_games!.getSS(id),
        builder: (context, AsyncSnapshot<List<ImagesModel>?> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text('Hay un error en la petición'),);
              
            }else{
              if(snapshot.connectionState == ConnectionState.done){
              
                return _listGames(snapshot.data!);
              }else{
                return CircularProgressIndicator();
                
              }
            }
        }
      );
  }

  Widget _listGames(List<ImagesModel>? data) {
   
     return Padding(
       padding: const EdgeInsets.all(8.0),
       child: Container(
         height: 200,
         child: PageIndicatorContainer(
           align: IndicatorAlign.bottom,
           length: data!.length,
           indicatorSpace: 10.0,
           padding: EdgeInsets.all(3.0),
           indicatorColor: Colors.white,
           shape: IndicatorShape.circle(size: 8),
           indicatorSelectorColor: Colors.blue,
           child: PageView.builder(

              scrollDirection: Axis.horizontal,
              itemBuilder:(context,index){
                 ImagesModel images = data[index];
  
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(images.image!),
                          fit: BoxFit.cover
                        ),
                      ), 
                    ),
                   
                   
                  ],
                );
              } ,
              controller: controller,
              itemCount: data.length,
            ),
           

         ),
       ),
     );

  }
}
