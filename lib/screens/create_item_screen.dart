import 'package:flutter/material.dart';
import 'package:flutter_app/shared/create_item_view.dart';
import 'package:flutter_app/shared/login_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CreateItemScreen extends StatefulWidget {
  CreateItemScreen();

  @override
  _CreateItemScreenState createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: Builder(
          builder: (context) => PlatformIconButton(
            icon: Image.asset("graphics/ic_back.png"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(
        child: CreateItemView(),
      ),
    );
  }
}
