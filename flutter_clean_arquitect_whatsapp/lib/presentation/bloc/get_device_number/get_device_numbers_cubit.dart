
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/usecases/get_device_numbers_usecase.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/get_device_number/get_device_numbers_state.dart';

class GetDeviceNumbersCubit extends Cubit<GetDeviceNumbersState> {
  final GetDeviceNumberUseCase getDeviceNumberUseCase;
  GetDeviceNumbersCubit({required this.getDeviceNumberUseCase}) : super(GetDeviceNumbersInitial());

  Future<void> getDeviceNumbers() async {
    try{
      final contactNumbers = await getDeviceNumberUseCase.call();
      emit(GetDeviceNumbersLoaded(contacts: contactNumbers));
    
    }catch(_){
      emit(GetDeviceNumbersFailure());
    }
  }
}