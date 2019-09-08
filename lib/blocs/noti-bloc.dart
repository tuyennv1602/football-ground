import 'package:rxdart/rxdart.dart';

import 'base-bloc.dart';

class NotiBloc extends BaseBloc {
  final _notiCtrl = BehaviorSubject<bool>();
  Function(bool) get changeNotiFunc => _notiCtrl.add;
  Observable<bool> get notiStream => Observable(_notiCtrl);

  @override
  void dispose() {
    _notiCtrl.close();
  }

  @override
  void initState() {}
}
