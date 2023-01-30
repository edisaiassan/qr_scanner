import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage>
    with AutomaticKeepAliveClientMixin<ScanQrPage> {
  @override
  bool get wantKeepAlive => false;

  final qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: (QRViewController controller) {
            setState(() => this.controller = controller);
            controller.scannedDataStream.listen(
              (bardcode) => setState(() => barcode = bardcode),
            );
            controller.pauseCamera();
            controller.resumeCamera();
          },
          overlay: QrScannerOverlayShape(
            borderWidth: 8.0,
            borderLength: 48.0,
            borderRadius: 16.0,
            borderColor: Theme.of(context).colorScheme.secondary,
            cutOutSize: MediaQuery.of(context).size.width * 0.75,
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width - 32.0,
          bottom: 8.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                barcode != null
                    ? 'Resultado : ${barcode!.code}'
                    : 'Escanear código',
                maxLines: 3,
              ),
            ),
          ),
        ),
        Positioned(
          top: 8.0,
          child: Wrap(
            runSpacing: 8.0,
            spacing: 8.0,
            children: [
              IconButton(
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                icon: FutureBuilder<bool?>(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(
                        snapshot.data! ? Icons.flash_on : Icons.flash_off,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () async {
                  await controller?.flipCamera();
                  setState(() {});
                },
                icon: FutureBuilder(
                    future: controller?.getCameraInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return const Icon(Icons.switch_camera);
                      } else {
                        return const SizedBox();
                      }
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
