import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/login_button.dart';
import 'package:flutter_app/utils/get_image.dart';

import '../logout_button.dart';

class ProfileView extends StatefulWidget {
  const ProfileView();

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        User? user = snapshot.data;
        return Container(
          width: double.infinity,
          color: Color(0xff333333),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  getImage(context, (image) {
                    if (image == null) return;

                    setState(() {
                      _image = File(image.path);
                    });
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.circular(100)),
                      child: ClipRRect(
                        child: _image != null
                            ? Image.file(_image!, fit: BoxFit.fill)
                            : user?.photoURL != null
                                ? Image.network(user!.photoURL!,
                                    fit: BoxFit.cover)
                                : Image.asset(
                                    'graphics/anonymous_user.png',
                                    fit: BoxFit.cover,
                                  ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 6, 20, 6),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: user == null
                        ? _buildNotLoggedIn()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text(user.displayName ?? "",
                                    style: TextStyle(fontWeight: FontWeight.w500)),
                                leading: Icon(
                                  Icons.person,
                                ),
                              ),
                              if (user.phoneNumber?.isNotEmpty == true)
                                ListTile(
                                  title: Text(user.phoneNumber ?? "",
                                      style:
                                          TextStyle(fontWeight: FontWeight.w500)),
                                  leading: Icon(
                                    Icons.phone,
                                  ),
                                ),
                              ListTile(
                                title: Text(user.email ?? "",
                                    style: TextStyle(fontWeight: FontWeight.w500)),
                                leading: Icon(
                                  Icons.email,
                                ),
                              ),
                              SizedBox(height: 24),
                              LogoutButton(),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildNotLoggedIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("You are not logged in"),
        SizedBox(height: 24),
        LoginButton(),
      ],
    );
  }
}
