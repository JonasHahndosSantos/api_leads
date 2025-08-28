import 'package:diacritic/diacritic.dart';
import 'package:vaden/vaden.dart';

@DTO()
class LeadDto {
  final String id_leads_comercial;
  DateTime? data_hora;
  final String? nome;
  final String? email;
  final String? cnpj;
  final String? telefone;
  final Interesse interesse;
  final String? fonte;
  final String? meio;
  final String? parceiros;
  final String? anuncio;
  final Status status;
  final String? cidade;

  LeadDto({
    required this.id_leads_comercial,
    required this.data_hora,
    required this.nome,
    required this.email,
    required this.cnpj,
    required this.telefone,
    required this.interesse,
    required this.fonte,
    required this.meio,
    required this.parceiros,
    required this.anuncio,
    required this.status,
    required this.cidade,
  });
}

enum Interesse {
  utilizacao,
  revenda;

  static const _displayNames = {
    'utilizacao': 'Utilização',
    'revenda': 'Revenda',
  };

  String get displayName => _displayNames[name]!;

  static Interesse fromName(String value) {
    String cleanedValue = removeDiacritics(value).toLowerCase();
    return Interesse.values.firstWhere(
          (e) => e.name.toLowerCase() == cleanedValue,
      orElse: () => Interesse.utilizacao,
    );
  }
}

enum Status {
  concluido,
  pendente;

  static const _displayNames = {
    'concluido': 'Concluído',
    'pendente': 'Pendente',
  };

  String get displayName => _displayNames[name]!;

  static Status fromName(String value) {
    String cleanedValue = removeDiacritics(value).toLowerCase();
    return Status.values.firstWhere(
          (e) => e.name.toLowerCase() == cleanedValue,
      orElse: () => Status.pendente,
    );
  }
}