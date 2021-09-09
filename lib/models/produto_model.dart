import 'dart:typed_data';
 
import 'package:cloud_firestore/cloud_firestore.dart';
 
class ProdutoModel {
  final String? key;
  final String ownerKey;
  final String nome;
  final String marca;
  final String preco;
  final String tamanho;
  final String cor;
  final String categoria;
  final String descricao;
  final Uint8List? imagem;
  final Uint8List? imagem2;
  final Uint8List? imagem3;
 
  ProdutoModel({
    this.key,
    required this.ownerKey,
    required this.nome,
    required this.marca,
    required this.preco,
    required this.tamanho,
    required this.cor,
    required this.categoria,
    required this.descricao,
    this.imagem,
    this.imagem2,
    this.imagem3,
  });
 
  static ProdutoModel fromMap(Map<String, dynamic> map, [String? key]) =>
      ProdutoModel(
        key: key,
        ownerKey: map['ownerKey'],
        nome: map['nome'],
        marca: map['marca'],
        preco: map['preco'],
        tamanho: map['tamanho'],
        cor: map['cor'],
        categoria: map['categoria'],
        descricao: map['descricao'],
        imagem: map['imagem']?.bytes,
        imagem2: map['imagem2']?.bytes,
        imagem3: map['imagem3']?.bytes,
      );
 
  Map<String, dynamic> toMap() => {
        'ownerKey': ownerKey,
        'nome': nome,
        'marca': marca,
        'preco': preco,
        'tamanho': tamanho,
        'cor': cor,
        'categoria': categoria,
        'descricao': descricao,
        'imagem': imagem != null ? Blob(imagem!) : null,
        'imagem2': imagem2 != null ? Blob(imagem2!) : null,
        'imagem3': imagem3 != null ? Blob(imagem3!) : null,
      };
}