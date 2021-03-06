import 'package:flutter/material.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/resource/styles.dart';
import 'package:footballground/util/date_util.dart';
import 'package:footballground/view/ui_helper.dart';

typedef void OnSelectedTime(double start, double end);

class TimeSliderWidget extends StatefulWidget {
  final OnSelectedTime onSelectedTime;

  TimeSliderWidget({@required OnSelectedTime onSelectedTime})
      : this.onSelectedTime = onSelectedTime;

  @override
  State<StatefulWidget> createState() {
    return TimeSliderState();
  }
}

class TimeSliderState extends State<TimeSliderWidget> {
  RangeValues _values = RangeValues(4, 23.5);

  @override
  Widget build(BuildContext context) {
    var formattedStart = DateUtil().getTimeStringFromDouble(_values.start);
    var formattedEnd = DateUtil().getTimeStringFromDouble(_values.end);
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: UIHelper.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Khung giờ hoạt động',
                style: textStyleRegular(),
              ),
              Text(
                '$formattedStart - $formattedEnd',
                style: textStyleSemiBold(),
              )
            ],
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
              trackHeight: UIHelper.size5,
              valueIndicatorTextStyle: textStyleSemiBold(color: Colors.white)),
          child: RangeSlider(
            max: 24,
            min: 0,
            divisions: 48,
            labels: RangeLabels('$formattedStart', '$formattedEnd'),
            activeColor: PRIMARY,
            values: _values,
            onChanged: (values) {
              this.setState(
                () {
                  if (values.end - values.start >= 1.5) {
                    _values = RangeValues(values.start, values.end);
                  } else {
                    if (_values.start == values.start) {
                      _values = RangeValues(_values.start, _values.start + 1.5);
                    } else {
                      _values = RangeValues(_values.end - 1.5, _values.end);
                    }
                  }
                  widget.onSelectedTime(_values.start, _values.end);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
