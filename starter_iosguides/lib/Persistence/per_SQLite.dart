import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


// 1. create database

void main() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
    },

    version: 1,
  );

  // 2. insert dog info
  Future<void> insertDog(Dog dog) async {
    final Database db = await database;

    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 2. query db
  Future<List<Dog>> dogs() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  // 3. update dog info
  Future<void> updateDog(Dog dog) async {
    final db = await database;

    await db.update(
      'dogs',
      dog.toMap(),
      where: 'id = ?',
      whereArgs: [dog.id],
    );
  }

  // 4. delete dog
  Future<void> deleteDog(int id) async {
    final db = await database;

    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  var fido = Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  await insertDog(fido);

  print(await dogs());

  fido = Dog(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );

  await updateDog(fido);

  print(await dogs());

  await deleteDog(fido.id);

  print(await dogs());

}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}