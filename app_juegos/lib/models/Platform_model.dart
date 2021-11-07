import 'package:flutter/rendering.dart';


class PlatformPlatform {
  int? id;
  String? name;
  String? slug;
  dynamic image;
  dynamic yearEnd;
  int? yearStart;
  int? gamesCount;
  String? imageBackground;

  PlatformPlatform({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.yearEnd,
    this.yearStart,
    this.gamesCount,
    this.imageBackground,
  });

  factory PlatformPlatform.fromMap(Map<String,dynamic> map){
    return PlatformPlatform(
      id : map['id'],
      name: map['name'],
      slug: map['slug'],
      image: map['image'],
      yearEnd: map['yearEnd'],
      yearStart: map['yearStart'],
      gamesCount: map['gamesCount'],
      imageBackground: map['imageBackground'],

    );
  }
}