import 'package:api_leads/src/modules/leads/dtos/leads_dto.dart';
import 'package:api_leads/src/modules/leads/enum/interesse.dart';
import 'package:api_leads/src/modules/leads/enum/status.dart';
import 'package:api_leads/src/modules/leads/repositorys/i_lead_repository.dart';
import 'package:api_leads/src/shared/database/database.dart';
import 'package:vaden/vaden.dart';

@Scope(BindType.instance)
@Repository()
class LeadRepository implements ILeadRepository{
  final Database _database;
  String get _getTableName => 'leads_comercial';
  String get _getIdColumn => 'id_leads_comercial';

  LeadRepository(this._database);

  @override
  Future<List<LeadDto>> getAll(int limit, int offset) async {
     String sql = 'SELECT id_leads_comercial, nome, email, telefone, cnpj, anuncio, meio, status, fonte, interesse, data_hora FROM $_getTableName LIMIT @limit OFFSET @offset';

    final results = await _database.query(sql:  sql, parameters: {'limit': limit, 'offset': offset,});
     return results.map((e) => fromMap(e)).toList();
  }

  @override
  Future<LeadDto> update(LeadDto lead) async {
    await _database.update(tableName: _getTableName, values: toMap(lead), idColumn: _getIdColumn);
    return lead;
  }

  Map<String, dynamic> toMap(LeadDto lead) {
    return {
      'id_leads_comercial': lead.id_leads_comercial,
      'status': lead.status.value,
      'interesse': lead.interesse.value,
    };
  }
  LeadDto fromMap(Map<String, dynamic> map) => LeadDto(
    id_leads_comercial: map['id_leads_comercial'],
    nome: map['nome'],
    email: map['email'],
    telefone: map['telefone'],
    cnpj: map['cnpj'],
    anuncio: map['anuncio'],
    meio: map['meio'],
    fonte: map['fonte'],
    data_hora: map['data_hora'],
    interesse: Interesse.values.firstWhere(
        (e) => e.value == map['interesse'],
      orElse: () => Interesse.utilizacao,
    ),
    status: Status.values.firstWhere(
        (e) => e.value == map['status'],
      orElse: () => Status.pendente,
    ),
  );

}

