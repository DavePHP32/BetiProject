class Song {
  int id;
  String titre;
  String interprete;
  String urlAudio;
  String paroles;
  int categorieId;

  Song({
    required this.id,
    required this.titre,
    required this.interprete,
    required this.urlAudio,
    required this.paroles,
    required this.categorieId,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      titre: json['titre'],
      interprete: json['interprete'],
      urlAudio: json['urlAudio'],
      paroles: json['paroles'],
      categorieId: json['categorieId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'interprete': interprete,
      'urlAudio': urlAudio,
      'paroles': paroles,
      'categorieId': categorieId,
    };
  }
}
