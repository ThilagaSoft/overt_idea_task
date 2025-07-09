import 'package:flutter/material.dart';
import 'package:map_pro/controller/qrCode_controller.dart';
import 'package:map_pro/utility/theme/app_color.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRScanScreen extends StatelessWidget {
  final QRCodeController qrController;

  const QRScanScreen({super.key, required this.qrController});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final qrSize = (size.width < 400 || size.height < 400) ? 250.0 : 300.0;

    return Center(
      child: SizedBox(
        width: qrSize,
        height: qrSize,
        child: QRView(
          key: qrController.qrKey,
          onQRViewCreated: (ctrl) => qrController.onQRViewCreated(context, ctrl),
          overlay: QrScannerOverlayShape(
            borderColor: AppColors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: qrSize - 40,
          ),
          onPermissionSet: (ctrl, p) => qrController.onPermissionSet(context, p),
        ),
      ),
    );
  }
}
