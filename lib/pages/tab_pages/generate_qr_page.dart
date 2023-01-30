import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrPage extends StatefulWidget {
  const GenerateQrPage({super.key});

  @override
  State<GenerateQrPage> createState() => _GenerateQrPageState();
}

class _GenerateQrPageState extends State<GenerateQrPage>
    with AutomaticKeepAliveClientMixin<GenerateQrPage> {
  @override
  bool get wantKeepAlive => false;

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        Container(
          alignment: Alignment.center,
          height: 164.0,
          child: QrImage(
            backgroundColor: Colors.cyan,
            data: controller.text,
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Ingrese su dato',
            suffixIcon: IconButton(
              onPressed: () => setState(() {}),
              icon: const Icon(
                Icons.done,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
