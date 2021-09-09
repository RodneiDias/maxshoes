import 'dart:typed_data';

class UserModel {
  final String nome;
  final String? key;
  final Uint8List? image;
  UserModel({required this.nome, this.key, this.image});

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      nome: map['nome'],
      key: map['key'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'key': key,
      'image': image,
    };
  }
}
