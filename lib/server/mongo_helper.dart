import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import '../models/enum_app.dart';

const MONGO_URL = "mongodb+srv://$USERNAME:$PASSWORD@cluster0.fmrfcsv.mongodb.net/$DATABASE_NAME?retryWrites=true&w=majority&appName=Cluster0";
const USERNAME = "everyone";
const PASSWORD = "NOb7jpHjkBRbKYBJ";
const DATABASE_NAME = "Dictionary";
const COLLECTION_CONTENT = 'Content';

class MongoHelper {
  static var db;
  static var collection;

  Future<bool> connect() async {
    try {
      db = await Db.create(MONGO_URL);
      await db.open();
      inspect(db);
      collection = db.collection(COLLECTION_CONTENT);
      return true;
    } catch(e) {
      print('Fail to connect to mongoDB: $e');
      return false;
    }
  }

  Future<bool> disconnect() async {
    try {
      await db.close();
      return true;
    } catch(e) {
      print('Fail to disconnect to mongoDB: $e');
      return false;
    }
  }

  Future<ResultConnect> upload(String user, String pw, var grammar, var words) async {
    try {
      bool ret = await connect();
      if(!ret) return ResultConnect.error;

      var data = await collection.findOne({"username": user});
      if(data == null || data["password"] != pw) return ResultConnect.invalid;
      data["words"] = words;
      data["grammar"] = grammar;
      await collection.updateOne(where.eq('username', user), modify.set('words', words).set('grammar', grammar));
      ret = await disconnect();

      return ResultConnect.success;
    } catch(e) {
      print('[DICTIONARY][mongo_helper]: Fail to upload data to sever: $e');
      return ResultConnect.error;
    }
  }

  Future<Map<String, dynamic>> download(String user) async {
    try {
      bool ret = await connect();
      if(!ret) return {};

      var data = await collection.findOne({"username": user});
      ret = await disconnect();
      return data;
    } catch(e) {
      print('[DICTIONARY][mongo_helper]: Fail to download data from sever: $e');
      return {};
    }
  }
}