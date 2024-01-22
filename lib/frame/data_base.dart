// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class BitDataBase {
  static const String DATA_NAME = "im.db";
  static const String DATA_TABLENAME = "CHATSTABLE";
  static const String DATA_TABLENAME_MESSAGEAUDIO = "AUDIOTABLE";
  static const String DATA_TABLENAME_MESSAGEVIDEO = "VIDEOTABLE";
  static const String DATA_TABLENAME_MESSAGEIMAGE = "IMAGETABLE";
  static const String DATA_TABLENAME_MESSAGE = "MESSAGETABLE";
  static Future<Database> database = initDataBase();

  static Future<Database> initDataBase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DATA_NAME);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE $DATA_TABLENAME (id INTEGER, url TEXT, name TEXT, time TEXT,message TEXT,count INTEGER,state INTEGER,unique(id))');
      await db.execute(
          'CREATE TABLE $DATA_TABLENAME_MESSAGEAUDIO ( id TEXT,  audioFilePath TEXT, audioFileName TEXT,unique(id))');
      await db.execute(
          'CREATE TABLE $DATA_TABLENAME_MESSAGEVIDEO ( id TEXT,  url TEXT, width INTEGER, height INTEGER,unique(id))');
      await db.execute(
          'CREATE TABLE $DATA_TABLENAME_MESSAGEIMAGE ( id TEXT,  url TEXT, width INTEGER, height INTEGER,unique(id))');
      await db.execute(
          'CREATE TABLE $DATA_TABLENAME_MESSAGE ( messageId TEXT,  message TEXT, senderId TEXT,receiverId TEXT,time TEXT,contentType INTEGER,imageInfoId TEXT,messageAudioId TEXT,messageVideoId TEXT,unique(messageId))');
    });
  }
}
