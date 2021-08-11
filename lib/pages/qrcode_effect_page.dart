import 'package:flutter/material.dart';
import 'package:scanning_effect/components/qrcode_layout.dart';

class QRCodeEffectPage extends StatelessWidget {
  const QRCodeEffectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3 * 2;
    return Center(
      child: Container(
        child: QRCodeLayout(
          // 设置扫描框的大小
          size: Size(width, width),
          // 直角长度
          angleLength: 25,
          // 直角线粗细
          angleWidth: 4,
          // 边框宽度
          borderWidth: 0.5,
          // 是否显示边框
          showBorder: true,
          // 扫描动画时长
          animationDuration: 1500,
          // 扫描横线宽度
          scannerWidth: 1,
        ),
        color: Colors.transparent,
      ),
    );
  }
}
