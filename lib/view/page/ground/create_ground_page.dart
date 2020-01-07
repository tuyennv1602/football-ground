import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footballground/model/create_ground_param.dart';
import 'package:footballground/model/ground.dart';
import 'package:footballground/model/user.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/resource/images.dart';
import 'package:footballground/resource/styles.dart';
import 'package:footballground/view/page/base_widget.dart';
import 'package:footballground/view/widgets/app_bar_button.dart';
import 'package:footballground/view/widgets/app_bar_widget.dart';
import 'package:footballground/view/widgets/border_background.dart';
import 'package:footballground/view/widgets/bottom_sheet.dart';
import 'package:footballground/view/widgets/customize_button.dart';
import 'package:footballground/view/widgets/input_widget.dart';
import 'package:footballground/util/currency_input_formatter.dart';
import 'package:footballground/util/string_util.dart';
import 'package:footballground/view/ui_helper.dart';
import 'package:footballground/util/validator.dart';
import 'package:footballground/viewmodel/create_ground_vm.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateGroundPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final CreateGroundParam _params;
  String _groundName;
  String _role;
  String _addressName;
  String _phoneNumber;
  String _deposite;

  CreateGroundPage(
      {@required CreateGroundParam params})
      : _params = params;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _showChooseImage(BuildContext context, Function onImageReady) =>
      showModalBottomSheet(
        context: context,
        builder: (c) =>
            BottomSheetWidget(
              options: ['Chọn ảnh logo', 'Từ máy ảnh', 'Từ thư viện', 'Huỷ'],
              onClickOption: (index) async {
                if (index == 1) {
                  var image = await ImagePicker.pickImage(
                      source: ImageSource.camera,
                      maxHeight: 500,
                      maxWidth: 720);
                  onImageReady(image);
                } else if (index == 2) {
                  var image = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      maxHeight: 500,
                      maxWidth: 729);
                  onImageReady(image);
                }
              },
            ),
      );

  _handleCreateGround(BuildContext context, CreateGroundViewModel model) async {
    UIHelper.showProgressDialog;
    var resp = await model.createGround(
        Provider
            .of<User>(context)
            .id,
        Ground(
            name: _groundName,
            rule: _role,
            phone: _phoneNumber,
            address: _addressName,
            deposit: StringUtil.getPriceFromString(_deposite),
            lat: _params.address.coordinates.latitude,
            lng: _params.address.coordinates.longitude,
            wardId: StringUtil.getIdFromString(_params.addressInfo.wardId),
            districtId: StringUtil.getIdFromString(_params.addressInfo.districtId),
            provinceId: StringUtil.getIdFromString(_params.addressInfo.provinceId),
            wardName: _params.addressInfo.wardName,
            districtName: _params.addressInfo.districtName,
            provinceName: _params.addressInfo.provinceName));
    UIHelper.hideProgressDialog;
    if (resp.isSuccess) {
      UIHelper.showSimpleDialog('Đăng ký thành công sân bóng $_groundName',
          onConfirmed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst));
    } else {
      UIHelper.showSimpleDialog(resp.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    UIHelper().init(context);
    return Scaffold(
      backgroundColor: PRIMARY,
      body: Column(
        children: <Widget>[
          AppBarWidget(
            centerContent: Text(
              'Thông tin sân bóng',
              textAlign: TextAlign.center,
              style: textStyleTitle(),
            ),
            leftContent: AppBarButtonWidget(
              imageName: Images.BACK,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          Expanded(
            child: BorderBackground(
              child: BaseWidget<CreateGroundViewModel>(
                model: CreateGroundViewModel(
                  api: Provider.of(context),
                  groundServices: Provider.of(context),
                ),
                builder: (c, model, child) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      Container(
                        height: UIHelper.size(200),
                        color: GREY_BACKGROUND,
                        child: InkWell(
                          onTap: () =>
                              _showChooseImage(
                                  context, (image) => model.setImage(image)),
                          child: model.image == null
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(Images.GALLERY,
                                  width: UIHelper.size50,
                                  height: UIHelper.size50,
                                  color: Colors.grey),
                              Text('Ảnh sân bóng',
                                  style: textStyleSemiBold(
                                      color: Colors.grey))
                            ],
                          )
                              : Image.file(model.image, fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: UIHelper.size10, vertical: UIHelper.size10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InputWidget(
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Vui lòng nhập tên sân bóng';
                                  return null;
                                },
                                inputAction: TextInputAction.done,
                                labelText: 'Tên sân bóng',
                                onSaved: (value) => _groundName = value,
                              ),
                              InputWidget(
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Vui lòng nhập nội quy sân bóng';
                                  return null;
                                },
                                maxLines: 4,
                                maxLength: 500,
                                inputAction: TextInputAction.newline,
                                labelText: 'Nội quy sân bóng',
                                onSaved: (value) => _role = value,
                              ),
                              InputWidget(
                                formatter: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  CurrencyInputFormatter()
                                ],
                                inputAction: TextInputAction.newline,
                                labelText: 'Số tiền cọc sân',
                                onSaved: (value) => _deposite = value,
                              ),
                              InputWidget(
                                validator: Validator.validPhoneNumber,
                                maxLines: 1,
                                inputAction: TextInputAction.done,
                                inputType: TextInputType.phone,
                                labelText: 'Số điện thoại',
                                onSaved: (value) => _phoneNumber = value,
                              ),
                              InputWidget(
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Vui lòng nhập địa chỉ sân bóng';
                                  return null;
                                },
                                initValue: _params.address.addressLine,
                                maxLines: 2,
                                inputAction: TextInputAction.done,
                                labelText: 'Địa chỉ',
                                onSaved: (value) => _addressName = value,
                              ),
                              Text('Khu vực',
                                  style: textStyleInput(
                                      color: Colors.grey, size: 11)),
                              Text(
                                _params.addressInfo.getAddress,
                                style: textStyleInput(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomizeButton(
                        margin: EdgeInsets.all(UIHelper.size15),
                        child: Text(
                          'ĐĂNG KÝ',
                          style: textStyleButton(),
                        ),
                        onTap: () {
                          if (validateAndSave()) {
                            _handleCreateGround(context, model);
                          }
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
