
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String nome;
  final String? key;
  final String? ownerName;
  Uint8List? image;
  UserModel({ required this.nome, this.key, this.ownerName, this.image});

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      nome: map['nome'],
      key: map['key'],
      ownerName: map['ownerName'],
      image: map['image']?.bytes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'key': key,
      'ownerName': ownerName,
      'image': image != null ? Blob(image!) : null,
    };
  }
}
