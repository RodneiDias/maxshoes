import 'dart:typed_data';

class UserModel {
  final String nome;
  final String? key;
  final Int8List? image;
  final String? preco;
  UserModel({
    required this.nome,
    this.key, this.image, this.preco
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      nome: map['nome'],
      key: map['key'],
      image:map['image'],
      preco:map['preco']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'key': key,
      'image': image,
      'preco': preco,
    };
  }
}
