import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/chat/chat_bloc.dart';
import 'package:map_pro/bloc/chat/chat_state.dart';
import 'package:map_pro/utility/theme/app_color.dart';
import 'package:qr_flutter_new/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';

class QRCodeGenScreen extends StatelessWidget {
  const QRCodeGenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return Center(
            child: Shimmer.fromColors(
              baseColor: AppColors.grey.withOpacity(0.2),
              highlightColor: AppColors.grey.withOpacity(0.4),
              child: Container(
                height: 250,
                width: 250,
                color: AppColors.white,
              ),
            ),
          );
        } else if (state is FcmTokenState)
        {
          print(state.deviceToken);
          final token = state.deviceToken ?? "unknown";
          return Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: QrImageView(
              data: token,
              size: 250,
              backgroundColor: Colors.white,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
