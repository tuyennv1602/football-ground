import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/resource/fonts.dart';
import 'package:footballground/resource/styles.dart';
import 'package:footballground/view/ui_helper.dart';

class InputWidget extends StatelessWidget {
  final String initValue;
  final Function(String) validator;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final String errorText;
  final String labelText;
  final Function(String) onSaved;
  final TextStyle textStyle;
  final int maxLines;
  final int maxLength;
  final List<TextInputFormatter> formatter;

  InputWidget(
      {Key key,
      this.initValue,
      this.validator,
      this.inputType,
      this.inputAction,
      this.errorText,
      this.labelText,
      this.onSaved,
      this.maxLines = 1,
      this.maxLength = 200,
      this.textStyle,
      this.formatter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      cursorColor: PRIMARY,
      cursorWidth: 1,
      maxLines: maxLines,
      maxLength: maxLength,
      initialValue: initValue,
      validator: validator,
      keyboardType: inputType ?? TextInputType.text,
      textInputAction: inputAction ?? TextInputAction.done,
      onSaved: onSaved,
      style: textStyle ?? textStyleInput(),
      inputFormatters: formatter,
      decoration: InputDecoration(
        helperText: '',
        contentPadding: EdgeInsets.symmetric(vertical: UIHelper.size5),
        alignLabelWithHint: maxLines > 1,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: LINE_COLOR),
        ),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.red)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1.2, color: PRIMARY),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1.2, color: PRIMARY),
        ),
        labelText: labelText,
        errorText: errorText,
        counter: SizedBox(),
        helperStyle: TextStyle(
            fontFamily: REGULAR,
            color: Colors.red,
            fontSize: UIHelper.size(12)),
        errorStyle: TextStyle(
            fontFamily: REGULAR,
            color: Colors.red,
            fontSize: UIHelper.size(12)),
        labelStyle: textStyleInput(color: Colors.grey),
      ),
    );
  }
}
