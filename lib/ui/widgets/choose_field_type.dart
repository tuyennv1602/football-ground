import 'package:flutter/material.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/utils/constants.dart';
import 'package:footballground/utils/ui_helper.dart';
import 'custom_expansion_panel.dart';

typedef void OnSelectedType(int type);

class ChooseFieldTypeWidget extends StatefulWidget {
  final OnSelectedType onSelectedType;

  ChooseFieldTypeWidget({@required this.onSelectedType});

  @override
  State<StatefulWidget> createState() => _ChooseFieldTypeState();
}

class _ChooseFieldTypeState extends State<ChooseFieldTypeWidget> {
  bool _isExpanded = false;
  int _selectedType = Constants.VS7;

  String getTypeName(int type) {
    switch (type) {
      case Constants.VS5:
        return '5 vs 5';
      case Constants.VS7:
        return '7 vs 7';
      case Constants.VS9:
        return '9 vs 9';
      case Constants.VS11:
        return '11 vs 11';
      default:
        return '';
    }
  }

  Widget _buildItemType(int type) => InkWell(
        onTap: () {
          setState(() {
            _isExpanded = false;
            _selectedType = type;
          });
          widget.onSelectedType(type);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: UIHelper.size40, vertical: UIHelper.size(7)),
          child: Text(
            getTypeName(type),
            style: textStyleRegular(),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CustomExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        setState(() {
          _isExpanded = !isExpanded;
        });
      },
      children: <ExpansionPanel>[
        ExpansionPanel(
            headerBuilder: (c, isExpanded) {
              return Row(
                children: <Widget>[
                  Text(
                    'Loại sân',
                    style: textStyleRegularTitle(),
                  ),
                  Expanded(
                    child: Text(
                      getTypeName(_selectedType),
                      textAlign: TextAlign.right,
                      style: textStyleSemiBold(),
                    ),
                  ),
                  UIHelper.horizontalSpaceMedium
                ],
              );
            },
            isExpanded: _isExpanded,
            body: Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  _buildItemType(Constants.VS5),
                  _buildItemType(Constants.VS7),
                  _buildItemType(Constants.VS9),
                  _buildItemType(Constants.VS11),
                  UIHelper.verticalSpaceMedium
                ],
              ),
            ))
      ],
    );
  }
}
