import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/chat/chant_qr_screen_cubit.dart';
import 'package:map_pro/bloc/chat/chat_bloc.dart';
import 'package:map_pro/bloc/chat/chat_event.dart';
import 'package:map_pro/controller/qrCode_controller.dart';
import 'package:map_pro/utility/common_extension.dart';
import 'package:map_pro/utility/config/static_text.dart';
import 'package:map_pro/utility/theme/app_color.dart';
import 'package:map_pro/utility/theme/text_styles.dart';
import 'package:map_pro/view/chat/qr_code_generator.dart';
import 'package:map_pro/view/chat/qr_code_scan.dart';
import 'package:map_pro/view/widgets/button_widget.dart';
import 'package:map_pro/view/widgets/common_appBar.dart';

class QRCodePage extends StatelessWidget {
  final QRCodeController qrController;

  const QRCodePage({super.key, required this.qrController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ChatBloc>(), // still use ChatBloc for token
      child: Scaffold(
        appBar: CommonAppBar(title: StaticText.chat, backButton: true),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                tileColor: AppColors.primary.withOpacity(0.1),
                onTap: () {
                   context.read<ChatBloc>().add(FcmTokenRequest());
                  context.read<QrViewCubit>().showGenerate();
                },
                leading: const Icon(Icons.share),
                title: Text(StaticText.shareYourQRCode.tr(), style: TextStyles.boldText),
                trailing: Icon(Icons.arrow_forward_ios, color: AppColors.boxShade),
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: AppColors.primary.withOpacity(0.1),
                onTap: () {
                  context.read<QrViewCubit>().showScan();
                },
                leading: const Icon(Icons.qr_code_scanner),
                title: Text(StaticText.scanOtherQrCode.tr(), style: TextStyles.boldText),
                trailing: Icon(Icons.arrow_forward_ios, color: AppColors.boxShade),
              ),
              const SizedBox(height: 10),
              BlocBuilder<QrViewCubit, QrViewMode>(
                builder: (context, mode) {
                  switch (mode) {
                    case QrViewMode.scan:
                      return QRScanScreen(qrController: qrController);
                    case QrViewMode.generate:
                      return const QRCodeGenScreen();
                    case QrViewMode.tokenGot:
                      return Column(
                        children: [
                          if (qrController.scannedCode.value?.isNotEmpty ?? false)
                            Text(StaticText.deviceTokenSuccess, style: TextStyles.smallHintButtonText),
                          const SizedBox(height: 30),
                          if (qrController.scannedCode.value?.isNotEmpty ?? false)
                            ButtonWidget(
                              buttonText: StaticText.sendSms,
                              onSubmit: () {
                                Navigator.pushReplacementNamed(context, "/chat");
                              },
                            ),
                        ],
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
