import 'package:vaden/vaden.dart';

@Component()
enum Interesse{
  utilizacao('utilizacao'),
  revendas('revendas'),
  ;

  const Interesse(this.value);
  final String value;
}