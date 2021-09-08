import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/models/produto_model.dart';

class FemininoPage extends StatefulWidget {
  FemininoPage({Key? key}) : super(key: key);

  @override
  _FemininoPageState createState() => _FemininoPageState();
}

class _FemininoPageState extends State<FemininoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .where('categoria', isEqualTo: 'feminino')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final diarios = snapshot.data!.docs.map((map) {
            final data = map.data();
            return ProdutoModel.fromMap(data, map.id);
          }).toList();

          return ListView.builder(
            itemCount: diarios.length,
            itemBuilder: (context, index) {
              final diario = diarios[index];
              return ListTile(
                title: Text(diario.nome),
                subtitle: Row(
                  children: [
                    Icon(Icons.location_on),
                    Text(diario.categoria),
                  ],
                ),
                leading: diario.imagem != null
                    ? Image.memory(
                        diario.imagem!,
                        fit: BoxFit.cover,
                        width: 72,
                      )
                    : Container(
                        child: Icon(Icons.location_on),
                        width: 72,
                        height: double.maxFinite,
                        color: Colors.blue,
                      ),
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => EditDiarioPage(
                //         diario: diario,
                //       ),
                //     ),
                //   );
                // },
              );
            },
          );
        },
      ),
    );
  }
}
