import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
              onTap: () =>
                  _launchURL('https://www.instagram.com/tragovoltaje_oficial/'),
              child: FaIcon(
                FontAwesomeIcons.instagram,
                size: 50,
                color: Colors.pink,
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () => _launchURL(
                  'https://www.facebook.com/people/TragoVoltaje/61569200769920/'),
              child: FaIcon(
                FontAwesomeIcons.facebook,
                size: 50,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () => _launchURL(
                  'https://www.tiktok.com/@tragovoltaje_oficial?is_from_webapp=1&sender_device=pc'),
              child: FaIcon(
                FontAwesomeIcons.tiktok,
                size: 50,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () => _launchURL('https://www.google.com'),
              child: FaIcon(
                FontAwesomeIcons.google,
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
