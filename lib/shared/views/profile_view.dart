import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/get_image.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xff333333),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            child: Container(
              margin: EdgeInsets.all(20),
              height: 200.0,
              width: 200.0,
              child: ClipRRect(
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.fill)
                    : Image.network(
                        'graphics/ari.jpeg',
                        fit: BoxFit.cover,
                      ),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 6, 20, 6),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text("Ariel Fogelman",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(
                      Icons.person,
                    ),
                  ),
                  ListTile(
                    title: Text("Herzliya, Israel",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(
                      Icons.place,
                    ),
                  ),
                  ListTile(
                    title: Text("+972-54-123-4567",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(
                      Icons.phone,
                    ),
                  ),
                  ListTile(
                    title: Text("ari@thisisnotamail.com",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(
                      Icons.email,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
