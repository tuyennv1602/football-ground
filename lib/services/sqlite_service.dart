import 'package:flutter/services.dart';
import 'package:footballground/model/address_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class SQLiteServices {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    var directory = await getDatabasesPath();
    var path = join(directory, "region.db");
    bool isExist = await File(path).exists();
    if (!isExist) {
      print("Creating new copy from asset");
      ByteData data = await rootBundle.load("assets/data/region.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    } else {
      print("Opening existing database");
    }
    return await openDatabase(path);
  }

  Future<List<AddressInfo>> getAddressInfos(
      String province, String district, String ward) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        'select p.id as province_id, p.name as province_name, d.id as district_id, d.name as district_name, w.id as ward_id, w.name as ward_name from province p inner join district d on d.province_id = p.id inner join ward w on w.district_id = d.id where p.name like "%$province%" and d.name like "%$district%" and w.name like "%$ward%"');
    print(result);
    return result.map((item) => AddressInfo.fromJson(item)).toList();
  }
}
