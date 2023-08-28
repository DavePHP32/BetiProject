import 'song.dart';
class Favoris {
  int id;
  Song chant;

  Favoris({
    required this.id,
    required this.chant,
  });

  factory Favoris.fromJson(Map<String, dynamic> json) {
    return Favoris(
      id: json['id'],
      chant: Song.fromJson(json['chant']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chant': chant.toJson(),
    };
  }
}
