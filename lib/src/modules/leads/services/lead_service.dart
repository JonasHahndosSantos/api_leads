
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
  Future<List<LeadDto>> getAll({required int limit, required int offset, String? status, String? interesse, String? fonte, String? busca}) async{
    final list = await _repository.getAll(limit: limit, offset: offset, status: status, interesse: interesse, fonte: fonte, busca: busca );

    return list;
  }

  @override
  Future<Map<String, dynamic>> getCard({required String status, String? interesse, String? fonte, String? busca}) async{
    return _repository.getCard(status: status, interesse: interesse, fonte: fonte, busca: busca);
  }
  
  
}