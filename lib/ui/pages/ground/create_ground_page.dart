import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footballground/models/address_info.dart';
import 'package:footballground/models/ground.dart';
import 'package:footballground/models/user.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/images.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/pages/base_widget.dart';
import 'package:footballground/ui/widgets/app_bar_button.dart';
import 'package:footballground/ui/widgets/app_bar_widget.dart';
import 'package:footballground/ui/widgets/border_background.dart';
import 'package:footballground/ui/widgets/bottom_sheet_widget.dart';
import 'package:footballground/ui/widgets/button_widget.dart';
import 'package:footballground/ui/widgets/input_widget.dart';
import 'package:footballground/utils/currency_input_formatter.dart';
import 'package:footballground/utils/string_util.dart';
import 'package:footballground/utils/ui_helper.dart';
import 'package:footballground/utils/validator.dart';
import 'package:footballground/viewmodels/create_ground_viewmodel.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateGroundPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Address _address;
  final AddressInfo _addressInfo;
  String _groundName;
  String _role;
  String _addressName;
  String _phoneNumber;
  String _deposite;

  CreateGroundPage(
      {@required Address address, @required AddressInfo addressInfo})
      : _address = address,
        _addressInfo = addressInfo;

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
            lat: _address.coordinates.latitude,
            lng: _address.coordinates.longitude,
            wardId: StringUtil.getIdFromString(_addressInfo.wardId),
            districtId: StringUtil.getIdFromString(_addressInfo.districtId),
            provinceId: StringUtil.getIdFromString(_addressInfo.provinceId),
            wardName: _addressInfo.wardName,
            districtName: _addressInfo.districtName,
            provinceName: _addressInfo.provinceName));
    UIHelper.hideProgressDialog;
    if (resp.isSuccess) {
      UIHelper.showSimpleDialog('Đăng ký thành công sân bóng $_groundName',
          onTap: () =>
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
                      UIHelper.verticalSpaceMedium,
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: UIHelper.size10),
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
                                initValue: _address.addressLine,
                                maxLines: 2,
                                inputAction: TextInputAction.done,
                                labelText: 'Địa chỉ',
                                onSaved: (value) => _addressName = value,
                              ),
                              Text('Khu vực',
                                  style: textStyleInput(
                                      color: Colors.grey, size: 11)),
                              Text(
                                _addressInfo.getAddress,
                                style: textStyleInput(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      UIHelper.verticalSpaceLarge,
                      ButtonWidget(
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
