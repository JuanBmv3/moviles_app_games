import 'dart:convert';

import 'package:app_juegos/models/desc_game_model.dart';
import 'package:app_juegos/models/games_model.dart';
import 'package:app_juegos/models/images_game_model.dart';
import 'package:http/http.dart' as http;

class ApiGames{

  
  Future<List<GamesModel>?> getAll() async{
    //var URL = Uri.parse('https://api.rawg.io/api/games?ordering=-metacritic&key=e1eee148a6ad47e2bf39b56e2b47cc07');
    var URL = Uri.parse('https://api.rawg.io/api/games?&key=e1eee148a6ad47e2bf39b56e2b47cc07');

    final response = await http.get(URL);
    if(response.statusCode == 200){
      var games = jsonDecode(response.body)['results'] as List;
     List<GamesModel> listGames = games.map( (game) => GamesModel.fromMap(game)).toList();
     return listGames;
    }
  }

  Future<List<GamesModel>?> getAllTop() async{
    var URL2 = Uri.parse('https://api.rawg.io/api/games?ordering=-metacritic&key=e1eee148a6ad47e2bf39b56e2b47cc07');
    final response = await http.get(URL2);
    if(response.statusCode == 200){
      var games = jsonDecode(response.body)['results'] as List;
     List<GamesModel> listGames = games.map( (game) => GamesModel.fromMap(game)).toList();
   
     return listGames;
    }
  }


  Future<DescModel?> getDesc(id) async{
    var URL2 = Uri.parse('https://api.rawg.io/api/games/${id}?key=e1eee148a6ad47e2bf39b56e2b47cc07');
    final response = await http.get(URL2);
    if(response.statusCode == 200){
     Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
     DescModel listPopular = DescModel.fromMap(data);
     return listPopular;
    }else{
      return null;
    }
  }

  Future<List<ImagesModel>?> getSS(id) async{
    var URL2 = Uri.parse('https://api.rawg.io/api/games/${id}/screenshots?key=e1eee148a6ad47e2bf39b56e2b47cc07');
    final response = await http.get(URL2);
    if(response.statusCode == 200){
      var games = jsonDecode(response.body)['results'] as List;
     List<ImagesModel> listGames = games.map( (game) => ImagesModel.fromMap(game)).toList();
   
     return listGames;
    }
  }
      
}