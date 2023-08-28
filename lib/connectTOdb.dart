import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';

class ConnectToDB {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'my_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE categories (
            id INTEGER PRIMARY KEY,
            nom TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE songs (
            id INTEGER PRIMARY KEY,
            titre TEXT,
            interprete TEXT,
            urlAudio TEXT,
            paroles TEXT,
            categorieId INTEGER,
            FOREIGN KEY (categorieId) REFERENCES categories(id)
          )
        ''');
      },
    );
  }

  static Future<void> insertCategory(Category category) async {
    final db = await database;
    await db.insert('categories', category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> insertSong(Song song) async {
    final db = await database;
    await db.insert('songs', song.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // ...

  static Future<List<Song>> getAllSongs() async {
    final db = await database;
    final results = await db.query('songs');
    return results.map((result) =>
        Song(
          id: result['id'] as int,
          titre: result['titre'] as String,
          interprete: result['interprete'] as String,
          urlAudio: result['urlAudio'] as String,
          paroles: result['paroles'] as String,
          categorieId: result['categorieId'] as int,
        )
    ).toList();
  }
}

  // ...


class Category {
  int id;
  String nom;

  Category({
    required this.id,
    required this.nom,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
    };
  }
}

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

  Map<String, dynamic> toMap() {
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

void main() async {
  // Initialisation de la base de données
  await ConnectToDB._initDatabase();

  // Création de quelques catégories
  final categorie1 = Category(id: 1, nom: 'Pop');
  final categorie2 = Category(id: 2, nom: 'Rock');

  await ConnectToDB.insertCategory(categorie1);
  await ConnectToDB.insertCategory(categorie2);

  // Création de quelques chansons avec leurs catégories respectives
  final song1 = Song(
    id: 1,
    titre: 'Chanson 1',
    interprete: 'Interprète 1',
    urlAudio: 'url_audio1',
    paroles: 'Paroles de la chanson 1...',
    categorieId: categorie1.id,
  );

  final song2 = Song(
    id: 2,
    titre: 'Chanson 2',
    interprete: 'Interprète 2',
    urlAudio: 'url_audio2',
    paroles: 'Paroles de la chanson 2...',
    categorieId: categorie2.id,
  );

  // Insertion des chansons dans la base de données
  await ConnectToDB.insertSong(song1);
  await ConnectToDB.insertSong(song2);

  print("Chansons insérées avec succès !");
}
