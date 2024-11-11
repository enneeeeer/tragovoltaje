import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Síguenos en nuestras redes sociales'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _launchURL('https://www.instagram.com'),
              child: FaIcon(
                FontAwesomeIcons.instagram,
                size: 50,
                color: Colors.pink,
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () => _launchURL('https://www.facebook.com'),
              child: FaIcon(
                FontAwesomeIcons.facebook,
                size: 50,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () => _launchURL('https://www.tiktok.com'),
              child: FaIcon(
                FontAwesomeIcons.tiktok,
                size: 50,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
