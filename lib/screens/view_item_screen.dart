import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/item.dart';
import 'package:flutter_app/shared/views/view_item_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ViewItemScreen extends StatefulWidget {
  String id;
  Item? item;

  ViewItemScreen(this.id);
  ViewItemScreen.item(Item fullItem)
      : this.id = fullItem.id,
        this.item = fullItem;

  @override
  _ViewItemScreenState createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
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
        child: ViewItemView(widget.id),
      ),
    );
  }
}
