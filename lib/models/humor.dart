class Humor {
  final String? id;
  final String sentimento;
  final String? atividade; //precisa virar lista
  final String? anotacao;
  final String data;

  const Humor(
      {this.id,
      required this.sentimento,
      this.atividade,
      this.anotacao,
      required this.data});
}
