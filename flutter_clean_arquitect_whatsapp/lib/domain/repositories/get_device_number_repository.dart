import 'package:flutter_clean_arquitect_whatsapp/domain/entities/contact_entity.dart';

abstract class GetDeviceNumberRepository{
  Future<List<ContactEntity>> getDeviceNumbers();
}