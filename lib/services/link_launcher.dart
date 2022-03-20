import 'package:url_launcher/url_launcher.dart';

class LinkLauncher {
  static void govURL() async {
    const url = 'https://www.gov.ie/en/publication/c803e-managing-your-mood/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void hseURL() async {
    const url = 'https://www2.hse.ie/mental-health/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
