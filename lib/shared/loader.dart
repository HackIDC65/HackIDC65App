import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: PlatformCircularProgressIndicator(),);
  }
}
