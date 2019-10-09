import 'package:flutter/material.dart';
import 'package:footballground/ui/widgets/rotation_widget.dart';
import 'package:footballground/utils/ui_helper.dart';

bool _isShowing = false;
BuildContext _context, _dismissingContext;
bool _barrierDismissible = true;

Widget _progressWidget = RotationWidget(
  widget: Image.asset('assets/images/icn_loading.png'),
);

class ProgressDialog {
  _Body _dialog;

  ProgressDialog(BuildContext context, {bool isDismissible}) {
    _context = context;
    _barrierDismissible = isDismissible ?? true;
  }

  bool isShowing() {
    return _isShowing;
  }

  void dismiss() {
    if (_isShowing) {
      try {
        _isShowing = false;
        if (Navigator.of(_dismissingContext).canPop()) {
          Navigator.of(_dismissingContext).pop();
        }
      } catch (_) {}
    }
  }

  Future<bool> hide() {
    if (_isShowing) {
      try {
        _isShowing = false;
        Navigator.of(_dismissingContext).pop(true);
        return Future.value(true);
      } catch (_) {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  void show() {
    if (!_isShowing) {
      _dialog = new _Body();
      _isShowing = true;

      showDialog<dynamic>(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dismissingContext = context;
          return WillPopScope(
              onWillPop: () {
                return Future.value(_barrierDismissible);
              },
              child: _dialog);
        },
      );
    } else {}
  }
}

class _Body extends StatefulWidget {
  final _BodyState _dialog = _BodyState();

  @override
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _BodyState extends State<_Body> {
  @override
  void dispose() {
    _isShowing = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        SizedBox(
          width: UIHelper.size(55),
          height: UIHelper.size(55),
          child: _progressWidget,
        )
      ],
    );
  }
}
