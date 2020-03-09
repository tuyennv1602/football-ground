import 'package:flutter/material.dart';
import 'package:footballground/resource/colors.dart';
import 'package:footballground/resource/images.dart';
import 'package:footballground/resource/styles.dart';
import 'package:footballground/view/ui_helper.dart';
import 'package:footballground/view/widgets/app_bar_button.dart';
import 'package:footballground/view/widgets/app_bar_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

class QrScanPage extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          AppBarWidget(
            centerContent: Text(
              'Xác nhận thanh toán',
              textAlign: TextAlign.center,
              style: textStyleTitle(),
            ),
            leftContent: AppBarButtonWidget(
              imageName: Images.BACK,
              onTap: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: (controller) {
                      controller.scannedDataStream.listen((data) {
                        print(data);
                      });
                    },
                    overlay: QrScannerOverlayShape(
                      borderColor: PRIMARY,
                      borderRadius: 10,
                      borderLength: 30,
                      borderWidth: 10,
                    ),
                  ),
                ),
                Positioned(
                  top: UIHelper.screenHeight / 2,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Center(
                    child: Text(
                      'Đặt mã QR vào khung!',
                      textAlign: TextAlign.center,
                      style: textStyleBold(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
