import 'package:footballground/data/repositories/user-repository.dart';
import 'package:footballground/models/responses/base-response.dart';
import 'package:footballground/utils/constants.dart';
import 'package:rxdart/rxdart.dart';

import 'base-bloc.dart';

class RegisterBloc extends BaseBloc {
  var _userRepo = UserRepository();

  final _nameCtrl = BehaviorSubject<String>();
  Function(String) get changeNameFunc => _nameCtrl.add;
  Observable<String> get changeNameStream => Observable(_nameCtrl);

  final _emailCtrl = BehaviorSubject<String>();
  Function(String) get changeEmailFunc => _emailCtrl.add;
  Observable<String> get changeEmailStream => Observable(_emailCtrl);

  final _passwordCtrl = BehaviorSubject<String>();
  Function(String) get changePasswordFunc => _passwordCtrl.add;
  Observable<String> get changePasswordStream => Observable(_passwordCtrl);

  final _phoneNumberCtrl = BehaviorSubject<String>();
  Function(String) get changePhoneNumberFunc => _phoneNumberCtrl.add;
  Observable<String> get changePhoneNumberStream => Observable(_phoneNumberCtrl);

  final _submitRegisterCtrl = PublishSubject<bool>();
  Function(bool) get submitRegisterFunc => _submitRegisterCtrl.add;
  Observable<BaseResponse> get registerStream => Observable(_submitRegisterCtrl)
      .flatMap((_) => Observable.fromFuture(_register())
          .doOnListen(() => setLoadingFunc(true))
          .doOnError(() => setLoadingFunc(false))
          .doOnDone(() => setLoadingFunc(false)))
      .flatMap((res) => Observable.just(res));

  Future<BaseResponse> _register() async {
    return _userRepo.register(_nameCtrl.value, _emailCtrl.value, _passwordCtrl.value,
        _phoneNumberCtrl.value, [Constants.GROUND_OWNER]);
  }

  @override
  void dispose() {
    super.dispose();
    _emailCtrl.close();
    _passwordCtrl.close();
    _nameCtrl.close();
    _phoneNumberCtrl.close();
    _submitRegisterCtrl.close();
  }
}
