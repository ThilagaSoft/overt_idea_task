import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/utility/common_extension.dart';

class QrViewCubit extends Cubit<QrViewMode>
{
  QrViewCubit() : super(QrViewMode.none);

  void showScan() => emit(QrViewMode.scan);
  void showGenerate() => emit(QrViewMode.generate);
  void showTokenData() => emit(QrViewMode.tokenGot);
  void reset() => emit(QrViewMode.none);
}
