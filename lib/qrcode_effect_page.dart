import 'package:flutter/material.dart';
import 'package:scanning_effect/components/qrcode_layout.dart';

class QRCodeEffectPage extends StatelessWidget {
  const QRCodeEffectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: QRCodeLayout(
          // 设置扫描框的大小
          size: Size(300, 300),
          // 直角长度
          angleLength: 30,
          // 直角线粗细
          angleWidth: 5,
          // 边框宽度
          borderWidth: 0.5,
          // 是否显示边框
          showBorder: true,
        ),
        color: Colors.transparent,
      ),
    );
  }
}
