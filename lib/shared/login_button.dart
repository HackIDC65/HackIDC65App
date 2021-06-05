import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton.text(
      "Login now",
      onPressed: () async {
        await Navigator.of(context).push(platformPageRoute(
          context: context,
          builder: (BuildContext context) {
            return LoginScreen();
          },
        ));
      },
    );
  }
}
