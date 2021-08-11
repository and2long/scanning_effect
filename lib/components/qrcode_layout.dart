import 'package:flutter/material.dart';

class QRCodeLayout extends StatefulWidget {
  final Size size;

  const QRCodeLayout({Key? key, required this.size}) : super(key: key);

  @override
  _QRCodeLayoutState createState() => _QRCodeLayoutState();
}

class _QRCodeLayoutState extends State<QRCodeLayout> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size,
      painter: QRCodeBorderPainter(),
      foregroundPainter: QRCodeScannerPainter(),
    );
  }
}

/// 二维码边框
class QRCodeBorderPainter extends CustomPainter {
  Paint _paint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 5;

  double angleWidth = 30;

  @override
  void paint(Canvas canvas, Size size) {
    // 左上角
    canvas.drawLine(Offset(0, 0), Offset(0, angleWidth), _paint);
    canvas.drawLine(Offset(0, 0), Offset(angleWidth, 0), _paint);
    // 右上角
    canvas.drawLine(
        Offset(size.width - angleWidth, 0), Offset(size.width, 0), _paint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, angleWidth), _paint);
    // 左下角
    canvas.drawLine(
        Offset(0, size.height), Offset(0, size.height - angleWidth), _paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(angleWidth, size.height), _paint);
    // 右下角
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width, size.height - angleWidth), _paint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - angleWidth, size.height), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// 中间扫描器
class QRCodeScannerPainter extends CustomPainter {
  Paint _paint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(0, size.width / 2), Offset(size.width, size.width / 2), _paint);
    // Path path = Path();
    // path.moveTo(0, 100);
    // path.conicTo(size.width / 2, 50, size.width, 100, 1);
    // canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
