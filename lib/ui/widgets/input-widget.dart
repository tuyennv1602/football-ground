import 'package:flutter/material.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/fonts.dart';

typedef void OnChangedText(String text);
typedef void OnSubmitText(String text);
typedef String OnValidator(String text);

class InputWidget extends StatefulWidget {
  final String labelText;
  final String initValue;
  final String errorText;
  final bool obscureText;
  final OnChangedText onChangedText;
  final OnSubmitText onSubmitText;
  final OnValidator validator;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int maxLines;
  final int maxLength;

  InputWidget(
      {Key key,
      this.labelText,
      this.obscureText,
      @required this.onChangedText,
      this.validator,
      this.initValue,
      this.inputAction,
      this.inputType,
      this.errorText,
      this.maxLines,
      this.maxLength,
      this.onSubmitText})
      : assert(onChangedText != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => InputState();
}

class InputState extends State<InputWidget> {
  TextEditingController _controller = new TextEditingController();
  FocusNode _textFocus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _textFocus.addListener(onChange);
    _controller.addListener(onChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _textFocus.dispose();
    super.dispose();
  }

  void onChange() {
    String text = _controller.text;
    if (_textFocus.hasFocus) {
      widget.onChangedText(text);
    }
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        autocorrect: false,
        cursorColor: AppColor.PRIMARY,
        cursorWidth: 1,
        maxLength: widget.maxLength ?? 50,
        maxLines: widget.maxLines ?? 1,
        style: TextStyle(
            fontFamily: Fonts.REGULAR,
            fontSize: 16,
            color: AppColor.BLACK_TEXT,
            letterSpacing: 0.15),
        initialValue: widget.initValue,
        controller: _controller,
        focusNode: _textFocus,
        validator: widget.validator,
        onFieldSubmitted: widget.onSubmitText,
        obscureText: widget.obscureText ?? false,
        keyboardType: widget.inputType ?? TextInputType.text,
        textInputAction: widget.inputAction ?? TextInputAction.next,
        decoration: InputDecoration(
          alignLabelWithHint: widget.maxLines != null,
          border: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColor.LINE_COLOR),
          ),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.red)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: AppColor.PRIMARY),
          ),
          labelText: widget.labelText,
          errorText: widget.errorText,
          counter: SizedBox(),
          errorStyle: TextStyle(
              fontFamily: Fonts.REGULAR, color: Colors.red, fontSize: 11),
          labelStyle: TextStyle(
              fontFamily: Fonts.REGULAR, color: Colors.grey, fontSize: 15),
        ),
      );
}
