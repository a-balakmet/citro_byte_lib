import 'package:flutter/cupertino.dart';

mixin CupertinoDialogs {
  CupertinoAlertDialog okDialog(
    String dialogTitle,
    String? dialogText,
    VoidCallback onDismiss,
  ) {
    return CupertinoAlertDialog(title: Text(dialogTitle), content: dialogText != null ? Text(dialogText) : null, actions: [
      CupertinoDialogAction(
        child: const Text('OK'),
        onPressed: () => onDismiss(),
      )
    ]);
  }

  CupertinoAlertDialog yesNoDialog(
    String? dialogTitle,
    String? dialogText,
    String yesText,
    String noText,
    VoidCallback onYes,
    VoidCallback onNo,
  ) {
    return CupertinoAlertDialog(title: dialogTitle != null ? Text(dialogTitle) : null, content: dialogText != null ? Text(dialogText) : null, actions: [
      CupertinoDialogAction(
        child: Text(
          noText,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        onPressed: () => onNo(),
      ),
      CupertinoDialogAction(
        child: Text(yesText),
        onPressed: () => onYes(),
      )
    ]);
  }
}
