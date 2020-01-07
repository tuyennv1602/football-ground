import 'package:flutter/cupertino.dart';
import 'package:footballground/services/sqlite_service.dart';
import 'package:footballground/viewmodel/base_viewmodel.dart';

class RegionViewModel extends BaseViewModel {
  SQLiteServices _sqLiteServices;

  RegionViewModel({@required SQLiteServices sqLiteServices})
      : _sqLiteServices = sqLiteServices;

}
