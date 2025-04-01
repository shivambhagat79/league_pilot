import 'package:url_launcher/url_launcher.dart';

Future<void> phoneLauncher(String phoneNumber) async {
  phoneNumber = "+91$phoneNumber";

  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch $phoneUri';
  }
}

Future<void> emailLauncher(String email) async {
  // phoneNumber = "+91$phoneNumber";

  final Uri emailUri = Uri(scheme: 'mailto', path: email);

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not launch $emailUri';
  }
}
