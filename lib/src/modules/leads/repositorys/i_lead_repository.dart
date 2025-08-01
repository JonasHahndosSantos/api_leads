
import 'package:api_leads/src/modules/leads/dtos/leads_dto.dart';

abstract interface class ILeadRepository{
  Future<LeadDto> update(LeadDto lead);

  Future<List<LeadDto>> getAll(int limit, int offset);

}