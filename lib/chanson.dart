import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class Chanson {
  final String id;
  final String titre;
  final String interprete;
  final String paroles ;
  final String urlAudio;
  final String production;

  Chanson({
    required this.id,
    required this.titre,
    required this.interprete,
    required this.paroles,
    required this.urlAudio,
    required this.production
  });

  factory Chanson.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Chanson(
      id: doc.id,
      titre: data['titre'],
      interprete: data['interprete'],
      paroles: data['paroles'],
      urlAudio: data['urlaudio'],
      production: data['production']
    );
  }
}
