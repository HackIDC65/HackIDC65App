import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'filled_button.dart';

class ErrorView extends StatelessWidget {
  final Function? onTryAgainPressed;
  final String? message;
  final String? buttonTitle;

  ErrorView({this.onTryAgainPressed, this.message, this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (message != null) Text(message!),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton.text(
              buttonTitle != null
                  ? buttonTitle!
                  : AppLocalizations.of(context)!.tryAgain,
              onPressed: onTryAgainPressed as void Function()?,
            ),
          )
        ],
      ),
    );
  }
}
