
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super(0);

  void onChangeTap(int index) => emit(index);
}