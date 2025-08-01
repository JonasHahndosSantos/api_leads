import 'package:postgres/postgres.dart';
import 'package:vaden/vaden.dart';

@Component()
class Database {
  final Connection _connection;

  Database(this._connection);

  Future<Result> _executeQuery({ required String query, Map<String, dynamic>? parameters, TxSession? txn}) async{
    final conn = txn ?? _connection;
    try {
      return await conn.execute(Sql.named(query), parameters: parameters);
    } catch(e){
      print(e.toString());
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> query({required String sql, Map<String, dynamic>? parameters, TxSession? txn}) async {
    final result = await _executeQuery(query: sql, parameters: parameters, txn: txn);
    return result.map((row) => row.toColumnMap()).toList();
  }
  Future<void> update({
    required String tableName,
    required Map<String, dynamic> values,
    required String idColumn,
    TxSession? txn,
  }) async {
    final updateValues = Map<String, dynamic>.from(values);
    final idValue = updateValues.remove(idColumn);

    final setClause = updateValues.keys
        .map((key) => '$key = @$key')
        .join(', ');

    final query = '''
    UPDATE $tableName
    SET $setClause
    WHERE $idColumn = @$idColumn
  ''';

    updateValues[idColumn] = idValue;

    await _executeQuery(query: query, parameters: updateValues, txn: txn);
  }
}