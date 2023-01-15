import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SaidSocialMediaBar extends StatelessWidget {
  SaidSocialMediaBar({Key? key}) : super(key: key);

  final socialMediaUrls = {
    'Facebook': 'https://www.facebook.com/saidcrc.org/',
    'Instagram': 'https://www.instagram.com/saidngo/',
    'Twitter': 'https://twitter.com/SAIDNG0',
    'LinkedIn': 'https://www.linkedin.com/in/said-ngo-358780120/',
  };

  Future<void> openLink(socialMediaKey) async {
    var url = socialMediaUrls[socialMediaKey];
    if (url == null) {
      return;
    }

    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () => openLink('Facebook'),
            icon: const Icon(Icons.facebook)),
        IconButton(
            onPressed: () => openLink('Instagram'),
            icon: const FaIcon(FontAwesomeIcons.instagram)),
        IconButton(
            onPressed: () => openLink('Twitter'),
            icon: const FaIcon(FontAwesomeIcons.twitter)),
        IconButton(
            onPressed: () => openLink('LinkedIn'),
            icon: const FaIcon(FontAwesomeIcons.linkedin)),
      ],
    );
  }
}
