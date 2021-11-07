import 'package:app_juegos/screens/views/list_games.dart';
import 'package:app_juegos/screens/views/top_games.dart';
import 'package:app_juegos/utils/colors_settings.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
     return DefaultTabController(
      
      length: 2,
      child: Scaffold(
        backgroundColor:  Colores.backgroundColor,
        appBar: AppBar(
          backgroundColor:  Colores.backgroundColor,
          title:  Text('Games App'),
          centerTitle: true,
          bottom: TabBar(
            tabs:[
              Tab(text: 'List Games', icon: Icon(Icons.sports_esports)),
              Tab(text: 'Top Games', icon: Icon(Icons.grade))
            ],
          ) ,
        ),
        body: TabBarView(
          children: [
            ListGamesScreen(),
            
            TopGamesScreen(),
          ]
        ),
      ),

    );
  }
}