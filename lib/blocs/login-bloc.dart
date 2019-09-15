import 'package:footballground/blocs/base-bloc.dart';
import 'package:footballground/data/app-api.dart';
import 'package:footballground/data/app-preference.dart';
import 'package:footballground/data/repositories/user-repository.dart';
import 'package:footballground/models/headers.dart';
import 'package:footballground/models/responses/login-response.dart';
import 'package:footballground/models/token.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc {
  var _userRepo = UserRepository();
  var _appPref = AppPreference();

  final _emailCtrl = BehaviorSubject<String>();
  Function(String) get changeEmailFunc => _emailCtrl.add;
  Observable<String> get changeEmailStream => Observable(_emailCtrl);

  final _passwordCtrl = BehaviorSubject<String>();
  Function(String) get changePasswordFunc => _passwordCtrl.add;
  Observable<String> get changePasswordStream => Observable(_passwordCtrl);

  final _submitLoginCtrl = PublishSubject<bool>();
  Function(bool) get submitLoginEmailFunc => _submitLoginCtrl.add;
  Observable<LoginResponse> get loginEmailStream => Observable(_submitLoginCtrl)
      .flatMap((_) => Observable.fromFuture(_loginEmail())
          .doOnListen(() => setLoadingFunc(true))
          .doOnError(() => setLoadingFunc(false))
          .doOnDone(() => setLoadingFunc(false)))
      .flatMap((res) => Observable.fromFuture(_handleLoginResp(res)))
      .flatMap((res) => Observable.just(res));

  Future<LoginResponse> _loginEmail() async {
    return _userRepo.loginWithEmail(_emailCtrl.value, _passwordCtrl.value);
  }

  Future<LoginResponse> _handleLoginResp(LoginResponse response) async {
    if (response.isSuccess) {
      await _appPref.setToken(Token(token: response.token, refreshToken: response.refreshToken));
      await _appPref.setUser(response.user);
      AppApi.setHeader(Headers(accessToken: response.token));
    }
    return Future.value(response);
  }

  @override
  void dispose() {
    super.dispose();
    _emailCtrl.close();
    _passwordCtrl.close();
    _submitLoginCtrl.close();
  }
}
