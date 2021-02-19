import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationWidget {
  static showNotification(BuildContext context, String title,
      {Icon icon, String subtitle, int duration = 6000}) {
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
                      : Icon(
                          Icons.check_circle,
                          color: Colors.green.shade200,
                          size: 40.0,
                        ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text(subtitle != null ? subtitle : ""),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                OverlaySupportEntry.of(context).dismiss();
              },
            ),
          ),
        ),
      );
    }, duration: Duration(milliseconds: duration));
  }
}
