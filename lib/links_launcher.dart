import 'dart:developer';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinksLauncher {
  Future<void> launchURL(String url) async {
    var clearUrl = url.replaceAll('\n', ''); // shit happens
    if (!url.startsWith('http')) {
      clearUrl = 'https://${url.replaceAll('\n', '')}'; // shit happens
    }
    if (Platform.isIOS) {
      if (await canLaunchUrlString(clearUrl)) {
        await launchUrlString(clearUrl);
      }
    } else {
      final uri = Uri.parse(clearUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    }
  }

  Future<void> makeCall(String phone) async {
    try {
      await launchUrl(Uri(scheme: 'tel', path: phone));
    } catch (e) {
      log('make call error $e');
    }
  }
}