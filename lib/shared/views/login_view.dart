import 'dart:io';
import "dart:math";

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/filled_button.dart';
import 'package:flutter_app/shared/loader.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // clientId: Platform.isIOS
  //     ? '57885613307-1up2gr6c04fa6l4d28140adv8vb87jdu.apps.googleusercontent.com'
  //     : null,
  scopes: <String>[
    'email',
  ],
);

class LoginView extends StatefulWidget {
  final Function onLoginSuccessfully;

  const LoginView({Key? key, required this.onLoginSuccessfully})
      : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  dynamic error;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // _googleSignIn.onCurrentUserChanged
    //     .listen((GoogleSignInAccount account) async {
    //   var hasSession = getIt<AppModel>().token != null;
    //   if (hasSession) return;
    //
    //   var user = await client.usersApi.googleLoginPost(account.id).catchError((e) {
    //     print(e);
    //   });
    //
    //   setState(() {
    //     _currentUser = account;
    //   });
    //   if (_currentUser != null) {
    //     // already logged in
    //     // _handleGetContact(_currentUser);
    //   }
    // });
    // _googleSignIn.signInSilently().then((account) {
    //   if (account == null) return null;
    //   return _authenticate(account);
    // }).catchError((e) => setState(() => error = e));
  }

  Future<void> _signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final firebaseUser = await FirebaseAuth.instance.signInWithCredential(credential);

      setState(() {
        isLoading = false;
        error = null;
      });

      widget.onLoginSuccessfully(firebaseUser);

      return;
    } catch (e) {
      print(e);
      setState(() {
        error = e;
      });
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      LoginResult result =
          await FacebookAuth.instance.login(permissions: ['email']);

      switch (result.status) {
        case LoginStatus.success:
          // result.accessToken!.token
          setState(() => isLoading = false);

          widget.onLoginSuccessfully();

          return;

        case LoginStatus.failed:
          throw result.message!;
        case LoginStatus.cancelled:
        case LoginStatus.operationInProgress:
          break;
      }
    } catch (e) {
      setState(() {
        error = e;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var error = this.error;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.loginTitle,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 26, letterSpacing: 1.5),
              ),
              SizedBox(height: 7),
              Text(
                AppLocalizations.of(context)!.loginSubtitle,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    FilledButton(
                      height: 42,
                      borderRadius: BorderRadius.circular(21),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          SizedBox(child: Image.asset("graphics/google.png"), height: 24, width: 24,),
                          Container(width: 8),
                          Text(AppLocalizations.of(context)?.loginUsingGoogle ??
                              ""),
                        ],
                      ),
                      onPressed: () {
                        _signInWithGoogle();
                      },
                    ),
                    SizedBox(height: 18),
                    FilledButton.text(
                      AppLocalizations.of(context)?.loginUsingFacebook ?? "",
                      onPressed: _signInWithFacebook,
                    ),
                    if (error != null)
                      Text(
                        error.toString().substring(
                            0, min(error.toString().length, 100)),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.red,
                            ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isLoading) Center(child: Loader()),
        PositionedDirectional(
          start: 16,
          bottom: 8,
          child: FilledButton.text(
            AppLocalizations.of(context)!.termsAndConditions,
            textStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
            padding: EdgeInsets.zero,
            height: 28,
            color: Colors.transparent,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
