import 'package:moor_flutter/moor_flutter.dart';

@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nom => text()();
}

@DataClassName('Song')
class Songs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get titre => text()();
  TextColumn get interprete => text()();
  TextColumn get urlAudio => text()();
  TextColumn get paroles => text()();
  IntColumn get categorieId => integer().customConstraint('REFERENCES categories(id)')();
}

