
import 'package:app_juegos/models/desc_game_model.dart';
import 'package:app_juegos/models/games_model.dart';
import 'package:app_juegos/network/api_games.dart';
import 'package:app_juegos/utils/colors_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';




class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

ApiGames? api_games;

@override
  void initState() {
    super.initState();
    api_games = ApiGames();
   
  } 
  
  @override
  Widget build(BuildContext context) {
    final game = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;


    return Scaffold(
      backgroundColor:  Colores.backgroundColor,
        appBar: AppBar(
          backgroundColor:  Colores.backgroundColor,
        ),
      body:ListView(
        shrinkWrap: true,
        children: [
          portada(game['background_image'], game['name'], game['id']),
          desc(game['id'])
        ]
      )
    );
  }

  Widget portada(image,name,id) { 
    return Container(
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
            child: Hero(
              tag: id,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image == null ? 'https://1.bp.blogspot.com/-7NqsY6kkUE0/V1CohGECLiI/AAAAAAAAAQw/eYszPqQmy-Q8hqnfROjlk0DFPmoS44-RACLcB/s1600/new%2B%25282%2529.png': image),
                    fit: BoxFit.cover
                  ),
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
                colors:[
                  Colors.black.withOpacity(.1),
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
                      image: NetworkImage(image == null ? 'http://lenguayliteratura.org/proyectoaula/wp-content/uploads/2016/02/no-logo.jpg': image),
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
            child: Text(name, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget desc(id) {
    return  FutureBuilder(
        future: api_games!.getDesc(id),
        builder: (context, AsyncSnapshot<DescModel?> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text('Hay un error en la petición'),);
              
            }else{
              if(snapshot.connectionState == ConnectionState.done){
                final desc = snapshot.data;
                print(desc!.descriptionRaw);
                return Container();

              
              }else{
                return Container();
              }
            }
        }
      ); 
  }
}
