import 'package:api_leads/src/modules/leads/dtos/leads_dto.dart';
import 'package:api_leads/src/modules/leads/repositorys/i_lead_repository.dart';
import 'package:api_leads/src/shared/database/database.dart';
import 'package:diacritic/diacritic.dart';
import 'package:vaden/vaden.dart';

@Scope(BindType.instance)
@Repository()
class LeadRepository implements ILeadRepository{
  final Database _database;
  String get _getTableName => 'leads_comercial';
  String get _getIdColumn => 'id_leads_comercial';

  LeadRepository(this._database);

  @override
  Future<List<LeadDto>> getAll({required int limit, required int offset, String? status, String? interesse, String? fonte,}) async {
    String sql = 'SELECT id_leads_comercial, nome, email, telefone, cnpj, anuncio, meio, status, fonte, interesse, data_hora, parceiros FROM $_getTableName ';
    final conditions = <String>[];
    final parameters = <String, dynamic>{
      'limit': limit,
      'offset': offset,
    };
    if(status != null){
      conditions.add('LOWER(status) = @status');
      parameters['status'] = status;
    }
    if(interesse != null){
      conditions.add('UNACCENT(LOWER(interesse)) = @interesse');
      parameters['interesse'] = removeDiacritics(interesse).toLowerCase();
    }
    if(fonte != null && fonte.isNotEmpty){
      conditions.add('fonte = @fonte');
      parameters['fonte'] = fonte;
    }

    if(conditions.isNotEmpty){
      sql += ' WHERE ${conditions.join(' AND ')}';
    }

    sql += ' ORDER BY data_hora DESC LIMIT @limit OFFSET @offset';

    final results = await _database.query(sql:  sql, parameters: parameters);

    return results.map((e) => fromMap(e)).toList();
  }

  @override
  Future<Map<String, dynamic>> getCard() async {
    String sql = '''
    SELECT
      COUNT(CASE WHEN status = 'pendente' THEN 1 END) AS total_ativos,
      COUNT(CASE WHEN interesse = 'Revenda' THEN 1 END) AS total_revendas,
      COUNT(CASE WHEN interesse = 'Utilização' THEN 1 END) AS total_utilizacao
    FROM leads_comercial;
  ''';

    final results = await _database.query(sql:  sql, parameters: {});

    return results.first;
  }

  @override
  Future<LeadDto> update(LeadDto lead) async {
    await _database.update(tableName: _getTableName, values: toMap(lead), idColumn: _getIdColumn);
    return lead;
  }

  Map<String, dynamic> toMap(LeadDto lead) {
    return {
      'id_leads_comercial': lead.id_leads_comercial,
      'status': lead.status.displayName,
      'interesse': lead.interesse.displayName,
      'parceiros': lead.parceiros,
    };
  }
  LeadDto fromMap(Map<String, dynamic> map) => LeadDto(
    id_leads_comercial: map['id_leads_comercial'].toString(),
    nome: map['nome'],
    email: map['email'],
    telefone: map['telefone'],
    cnpj: map['cnpj'],
    anuncio: map['anuncio'],
    meio: map['meio'],
    fonte: map['fonte'],
    parceiros: map['parceiros'],
    data_hora: map['data_hora'],
    interesse: Interesse.fromName(map['interesse']),
    status: Status.fromName(map['status']),
  );

}

