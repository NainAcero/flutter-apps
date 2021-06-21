import 'package:flutter_clean_arquitect_whatsapp/domain/entities/contact_entity.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/repositories/get_device_number_repository.dart';

class GetDeviceNumberUseCase{
  final GetDeviceNumberRepository deviceNumberRepository;

  GetDeviceNumberUseCase({required this.deviceNumberRepository});

  Future<List<ContactEntity>> call()async{
    return deviceNumberRepository.getDeviceNumbers();
  }
}