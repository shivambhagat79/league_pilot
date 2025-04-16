import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/pages/qr_scanner/scanned_player.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController _controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
  );

  bool _isTorchEnabled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final Barcode? barcode = capture.barcodes.first;
    if (barcode != null && barcode.rawValue != null) {
      final String qrData = barcode.rawValue!;
      // Stop scanning once a QR code is detected.
      _controller.stop();
      // Navigate to a new page with the scanned QR code data.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScannedPlayerPage(
            scannedString: qrData,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: 'Scan Player QR',
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height * 0.7,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MobileScanner(
                    controller: _controller,
                    onDetect: _onDetect,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white, // Or any color you prefer.
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // Optional rounded corners.
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton.filledTonal(
                onPressed: () {
                  _controller.switchCamera();
                },
                icon: Icon(
                  Icons.cameraswitch,
                  size: 40,
                  color: Colors.teal.shade800,
                ),
                padding: EdgeInsets.all(16),
              ),
              IconButton.filledTonal(
                onPressed: () {
                  _controller.toggleTorch();
                  setState(() {
                    _isTorchEnabled = !_isTorchEnabled;
                  });
                },
                padding: EdgeInsets.all(16),
                icon: Icon(
                  _isTorchEnabled ? Icons.flash_on : Icons.flash_off,
                  size: 40,
                  color: Colors.teal.shade800,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
