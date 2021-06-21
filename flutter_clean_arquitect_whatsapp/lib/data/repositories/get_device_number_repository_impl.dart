import 'package:flutter_clean_arquitect_whatsapp/data/local_datasource/local_datasource.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/entities/contact_entity.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/repositories/get_device_number_repository.dart';

class GetDeviceNumberRepositoryImpl implements GetDeviceNumberRepository {
  final LocalDataSource localDataSource;

  GetDeviceNumberRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ContactEntity>> getDeviceNumbers() {
    return localDataSource.getDeviceNumbers();
  }

}