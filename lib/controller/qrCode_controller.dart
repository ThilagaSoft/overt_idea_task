import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/chat/chant_qr_screen_cubit.dart';
import 'package:map_pro/database/local_db.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRCodeController {
  // Key for the QRView
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // Controller for the QRView
  QRViewController? qrViewController;

  // Notifier for the scanned code
  final ValueNotifier<String?> scannedCode = ValueNotifier<String?>(null);

  // Your local DB instance
  final LocalDatabase db = LocalDatabase.instance;

  /// Called when the QR view is created
   onQRViewCreated(BuildContext context, QRViewController controller) {
    qrViewController = controller;
    debugPrint("📷 QR View Created");

    controller.scannedDataStream.listen((scanData) async {
      final code = scanData.code;
      debugPrint("📸 Scanned QR: $code");

      // Only proceed if non-null, non-empty
      if (code != null && code.isNotEmpty) {
        // 1) Update the notifier
        scannedCode.value = code;

        // 2) Persist to your DB
        await db.saveSessionReceiverValue('loggedInReceiverId', code);

        // 3) Pause camera so we don't keep scanning duplicates
        await controller.pauseCamera();

        // 4) Tell the UI to switch to the "tokenGot" view
        context.read<QrViewCubit>().showTokenData();
      }
    });
  }

  /// Called if camera permission is granted/denied
  void onPermissionSet(BuildContext context, bool granted) {
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera permission not granted")),
      );
    }
  }

  /// Dispose when you're done scanning
  // void dispose() {
  //   qrViewController?.dispose();
  //   scannedCode.value = null;
  // }
}
