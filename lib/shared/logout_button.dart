import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton.text(
      "Logout",
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
      },
    );
  }
}
