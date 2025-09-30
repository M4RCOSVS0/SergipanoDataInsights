// lib/models/time.dart
class Time {
  final int timeId;
  final String nome;
  final int titulos;
  final int participacoes;
  final String fundacao;
  final String sede;
  final String escudo;

  Time({
    required this.timeId,
    required this.nome,
    required this.titulos,
    required this.participacoes,
    required this.fundacao,
    required this.sede,
    required this.escudo,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      timeId: json['timeId'],
      nome: json['nome'],
      titulos: json['titulos'],
      participacoes: json['participacoes'],
      fundacao: json['fundacao'],
      sede: json['sede'],
      escudo: json['escudo'],
    );
  }
}