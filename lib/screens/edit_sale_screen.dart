import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/shared/views/edit_sale_view.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditSaleScreen extends StatefulWidget {
  final Sale? sale;

  EditSaleScreen({this.sale});

  @override
  _EditSaleScreenState createState() => _EditSaleScreenState();
}

class _EditSaleScreenState extends State<EditSaleScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        material: (_, __) => MaterialAppBarData(elevation: 0),
        leading: Builder(
          builder: (context) => PlatformIconButton(
            icon: Image.asset("graphics/ic_back.png"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(widget.sale != null ? (widget.sale?.title ?? "no name") : (AppLocalizations.of(context)?.newSaleTitle ?? "")),
      ),
      backgroundColor: const Color(0xfffffbf4),
      body: SafeArea(
        child: EditSaleView(sale: widget.sale),
      ),
    );
  }
}
