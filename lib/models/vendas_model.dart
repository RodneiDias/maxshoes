class VendasModel {
  final String nome;
  final String marca;
  final double preco;
  final double precoTotal;
  final String categoria;
  final int quantidade;
 
  VendasModel({
    required this.nome,
    required this.marca,
    required this.preco,
    required this.precoTotal,
    required this.quantidade,
    required this.categoria,
  });
 
  static VendasModel fromMap(Map<String, dynamic> map, [String? key]) =>
      VendasModel(
        nome: map['nome'],
        marca: map['marca'],
        preco: map['preco'],
        precoTotal: map['precoTotal'],
        quantidade: map['quantidade'],
        categoria: map['categoria'],
      );
 
  Map<String, dynamic> toMap() => {
        'nome': nome,
        'marca': marca,
        'preco': preco,
        'precoTotal': precoTotal,
        'quantidade': quantidade,
        'categoria': categoria,
      };
}