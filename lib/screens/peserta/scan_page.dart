import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../models/user_profile.dart';
import '../../services/firestore_service.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({required this.profile, super.key});
  final UserProfile profile;

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final MobileScannerController _controller = MobileScannerController();
  bool _handled = false;
  String? _error;
  final TextEditingController _manualController = TextEditingController();

  Future<void> _handleBarcode(BarcodeCapture capture) async {
    if (_handled) return;
    if (capture.barcodes.isEmpty) return;
    final barcode = capture.barcodes.first;
    final sessionId = barcode.rawValue;
    if (sessionId == null || sessionId.isEmpty) {
      setState(() => _error = 'QR tidak valid.');
      return;
    }
    setState(() => _handled = true);
    final firestore = context.read<FirestoreService>();
    try {
      await firestore.markAttendance(sessionId: sessionId, user: widget.profile, method: 'qr');
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Berhasil'),
          content: Text('Absensi untuk sesi $sessionId tercatat.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
      if (mounted) Navigator.pop(context);
    } on Exception catch (e) {
      setState(() {
        _handled = false;
        _error = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _manualController.dispose();
    super.dispose();
  }

  Future<void> _submitManual() async {
    final sessionId = _manualController.text.trim();
    if (sessionId.isEmpty) {
      setState(() => _error = 'Kode sesi wajib diisi.');
      return;
    }
    final firestore = context.read<FirestoreService>();
    setState(() => _handled = true);
    try {
      await firestore.markAttendance(sessionId: sessionId, user: widget.profile, method: 'manual');
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Berhasil'),
          content: Text('Absensi untuk sesi $sessionId tercatat.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
      if (mounted) Navigator.pop(context);
    } on Exception catch (e) {
      setState(() {
        _handled = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pindai QR Presensi')),
      body: Column(
        children: [
          Expanded(
            child: kIsWeb
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Masukkan kode sesi (web tidak mendukung kamera langsung).',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _manualController,
                          decoration: const InputDecoration(
                            labelText: 'Kode sesi',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _handled ? null : _submitManual,
                            child: const Text('Kirim Absensi'),
                          ),
                        ),
                      ],
                    ),
                  )
                : MobileScanner(
                    controller: _controller,
                    onDetect: _handleBarcode,
                  ),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          if (!kIsWeb)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.lightbulb_outline),
                    onPressed: () => _controller.toggleTorch(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cameraswitch),
                    onPressed: () => _controller.switchCamera(),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Tutup'),
                  ),
                ],
              ),
            ),
          if (kIsWeb)
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tutup'),
              ),
            ),
        ],
      ),
    );
  }
}
