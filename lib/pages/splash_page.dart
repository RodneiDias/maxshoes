import 'package:flutter/material.dart';
import 'package:max_shoes_vendedor/pages/login_page.dart';
import 'package:provider/provider.dart';
import '../widgets/splash_loading_widget.dart';
import 'home_page.dart';
import '../controllers/user_controller.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, userController, child) {
        switch (userController.authState) {
          case AuthState.signed:
            return HomePage();
          case AuthState.unsigned:
            return LoginPage();
          case AuthState.loading:
            return SplashLoadingWidget();
        }
      },
    );
  }
}
