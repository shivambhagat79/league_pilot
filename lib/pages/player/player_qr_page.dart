import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PlayerQRPage extends StatefulWidget {
  final String playerEmail;
  const PlayerQRPage({super.key, required this.playerEmail});

  @override
  State<PlayerQRPage> createState() => _PlayerQRPageState();
}

class _PlayerQRPageState extends State<PlayerQRPage> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: 'Your QR Code',
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: widget.playerEmail,
              version: QrVersions.auto,
              size: 220.0,
            ),
            const SizedBox(height: 50),
            Text(
              'Scan this QR code verify your ID',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "© League Pilot. All rights reserved.",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
