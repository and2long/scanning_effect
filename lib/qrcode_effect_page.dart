import 'package:flutter/material.dart';
import 'package:scanning_effect/components/qrcode_layout.dart';

class QRCodeEffectPage extends StatelessWidget {
  const QRCodeEffectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: QRCodeLayout(size: Size(300, 300)),
        color: Colors.grey,
      ),
    );
  }
}
