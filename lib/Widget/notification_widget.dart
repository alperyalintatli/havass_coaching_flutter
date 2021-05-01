import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationWidget {
  static showNotification(BuildContext context, String title,
      {Icon icon,
      String subtitle,
      int duration = 6000,
      NotificationPosition position = NotificationPosition.top}) {
    showOverlayNotification((context) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: SafeArea(
          child: ListTile(
            leading: SizedBox.fromSize(
              size: const Size(40, 40),
              child: ClipOval(
                child: Container(
                  child: icon != null
                      ? icon
                      : Image.asset("images/havass_logo_1.png"),
                ),
              ),
            ),
            title: Text(AppLocalizations.getString('havass_notification_text')),
            subtitle: Text(title != null ? title : ""),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                OverlaySupportEntry.of(context).dismiss();
              },
            ),
          ),
        ),
      );
    }, duration: Duration(milliseconds: duration), position: position);
  }
}
