
import 'package:api_leads/src/modules/leads/dtos/leads_dto.dart';
import 'package:api_leads/src/modules/leads/repositorys/i_lead_repository.dart';
import 'package:api_leads/src/modules/leads/services/i_lead_service.dart';
import 'package:vaden/vaden.dart';

@Scope(BindType.instance)
@Service()
class LeadService implements ILeadService{
  final ILeadRepository _repository;
  
  LeadService(this._repository);

  @override
  Future<LeadDto> Update(LeadDto lead) async{
    return await _repository.update(lead);
  }

  @override
  Future<List<LeadDto>> getAll(int limit, int offset) async{
    return await _repository.getAll(limit, offset);
  }
  
  
}