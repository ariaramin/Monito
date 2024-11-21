part of 'circle_progress_bar.dart';

class CircleProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color? backgroundColor;
  final Color foregroundColor;

  CircleProgressBarPainter({
    this.backgroundColor,
    required this.foregroundColor,
    required this.percentage,
    double? strokeWidth,
  }) : strokeWidth = strokeWidth ?? 3;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final Size constrainedSize =
        size - Offset(strokeWidth, strokeWidth) as Size;
    final shortestSide = min(constrainedSize.width, constrainedSize.height);
    final foregroundPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final radius = (shortestSide / 2);

    // Start at the top. 0 radians represents the right edge
    const double startAngle = -(2 * pi * 0.25);
    final double sweepAngle = (2 * pi * (percentage));

    // Don't draw the background if we don't have a background color
    if (backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = backgroundColor!
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as CircleProgressBarPainter);
    return oldPainter.percentage != percentage ||
        oldPainter.backgroundColor != backgroundColor ||
        oldPainter.foregroundColor != foregroundColor ||
        oldPainter.strokeWidth != strokeWidth;
  }
}
