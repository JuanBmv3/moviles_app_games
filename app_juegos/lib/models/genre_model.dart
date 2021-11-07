import 'package:flutter/rendering.dart';

class Genre {
  int? id;
  String? name;
  String? slug;
  int? gamesCount;
  String? imageBackground;
  String? domain;


  Genre({
    this.id,
    this.name,
    this.slug,
    this.gamesCount,
    this.imageBackground,
    this.domain,
  });

  
  factory Genre.fromMap(Map<String,dynamic> map){
    return Genre(
      id : map['id'],
      name: map['name'],
      slug: map['slug'],
      gamesCount: map['gamesCount'],
      imageBackground: map['imageBackground'],
      domain: map['domain'],
    );
  }
}