import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/controllers/user_controller.dart';
import 'package:max_shoes_vendedor/pages/telas_page.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[
                Color(0xfff8f9fa),
                Color(0xffced4da),
                Color(0xff89c2d9),
                Color(0xffa9d6e5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.clamp),
        ),
        child: ListView(children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
            accountName: Text(userController.model.nome),
            accountEmail: Text(userController.user!.email!),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xfff8f9fa),
                    Color(0xffced4da),
                    Color(0xff89c2d9),
                    Color(0xffa9d6e5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.clamp),
            ),
            currentAccountPictureSize: Size.square(72),
          ),
          Divider(
            endIndent: 50,
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              'Lista de Produtos',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelasPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Masculino',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelasPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Feminino',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelasPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              'Infantil',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelasPage(),
                ),
              );
            },
          ),
          Divider(
            endIndent: 50,
            color: Colors.lightBlue,
          ),
        ]),
      ),
    );
  }
}


// class DrawerPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(children: [
//         UserAccountsDrawerHeader(
//           accountName: Text('nome'),
//           accountEmail: Text('email'),
//         ),
//         Divider(
//           endIndent: 50,
//           color: Colors.black,
//         ),
//         ListTile(
//           title: Text(
//             'Lista de Produtos',
//             style: TextStyle(fontSize: 18),
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => TelasPage(),
//               ),
//             );
//           },
//         ),
//         ListTile(
//           title: Text(
//             'Saldo',
//             style: TextStyle(fontSize: 18),
//           ),
//           onTap: () {},
//         ),
//         ListTile(
//           title: Text(
//             'Distribuidoras',
//             style: TextStyle(fontSize: 18),
//           ),
//           onTap: () {},
//         ),
//         ListTile(
//           title: Text(
//             'Desenvolvedores',
//             style: TextStyle(fontSize: 18),
//           ),
//           onTap: () {},
//         ),
//         Divider(
//           endIndent: 50,
//           color: Colors.lightBlue,
//         ),
//       ]),
//     );
//   }
// }
