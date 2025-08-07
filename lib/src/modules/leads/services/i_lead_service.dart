import 'package:api_leads/src/modules/leads/dtos/leads_dto.dart';

abstract interface class ILeadService{
  Future<LeadDto> Update(LeadDto lead);

  Future<List<LeadDto>> getAll({required int limit, required int offset, String? status, String? interesse, String? fonte,});

  Future<Map<String, dynamic>> getCard();
}