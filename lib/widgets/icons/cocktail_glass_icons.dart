import 'package:flutter/material.dart';

/// Custom cocktail glass icons for rating system
class CocktailGlassIcons {
  /// Martini glass icon
  static Widget martiniGlass({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: MartiniGlassPainter(color: color, filled: filled),
    );
  }

  /// Rocks glass (old fashioned) icon
  static Widget rocksGlass({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: RocksGlassPainter(color: color, filled: filled),
    );
  }

  /// Wine glass icon
  static Widget wineGlass({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: WineGlassPainter(color: color, filled: filled),
    );
  }

  /// Shot glass icon
  static Widget shotGlass({
    required double size,
    required Color color,
    bool filled = false,
  }) {
    return CustomPaint(
      size: Size(size, size),
      painter: ShotGlassPainter(color: color, filled: filled),
    );
  }

  /// Get a cocktail glass widget by type
  static Widget getCocktailGlass({
    required CocktailGlassType type,
    required double size,
    required Color color,
    bool filled = false,
  }) {
    switch (type) {
      case CocktailGlassType.martini:
        return martiniGlass(size: size, color: color, filled: filled);
      case CocktailGlassType.rocks:
        return rocksGlass(size: size, color: color, filled: filled);
      case CocktailGlassType.wine:
        return wineGlass(size: size, color: color, filled: filled);
      case CocktailGlassType.shot:
        return shotGlass(size: size, color: color, filled: filled);
    }
  }
}

enum CocktailGlassType { martini, rocks, wine, shot }

/// Custom painter for martini glass
class MartiniGlassPainter extends CustomPainter {
  final Color color;
  final bool filled;

  MartiniGlassPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Draw martini glass bowl (triangular)
    final path = Path();
    path.moveTo(center.dx - radius, center.dy - radius * 0.3);
    path.lineTo(center.dx + radius, center.dy - radius * 0.3);
    path.lineTo(center.dx, center.dy + radius * 0.3);
    path.close();

    canvas.drawPath(path, paint);

    // Draw stem
    canvas.drawLine(
      Offset(center.dx, center.dy + radius * 0.3),
      Offset(center.dx, center.dy + radius * 0.8),
      paint,
    );

    // Draw base
    canvas.drawLine(
      Offset(center.dx - radius * 0.3, center.dy + radius * 0.8),
      Offset(center.dx + radius * 0.3, center.dy + radius * 0.8),
      paint,
    );

    // Add olive or cherry if filled
    if (filled) {
      final olivePaint = Paint()..color = color.withValues(alpha: 0.8);
      canvas.drawCircle(
        Offset(center.dx, center.dy - radius * 0.1),
        3,
        olivePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for rocks glass
class RocksGlassPainter extends CustomPainter {
  final Color color;
  final bool filled;

  RocksGlassPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final width = size.width * 0.6;
    final height = size.height * 0.7;

    // Draw rocks glass (slightly tapered rectangle)
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: width, height: height),
      const Radius.circular(4),
    );

    canvas.drawRRect(rect, paint);

    // Add ice cubes if filled
    if (filled) {
      final icePaint = Paint()
        ..color = color.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill;

      // Ice cube 1
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(center.dx - 6, center.dy - 8),
            width: 8,
            height: 8,
          ),
          const Radius.circular(2),
        ),
        icePaint,
      );

      // Ice cube 2
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(center.dx + 4, center.dy),
            width: 6,
            height: 6,
          ),
          const Radius.circular(2),
        ),
        icePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for wine glass
class WineGlassPainter extends CustomPainter {
  final Color color;
  final bool filled;

  WineGlassPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    // Draw wine glass bowl (oval)
    final ovalRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy - radius * 0.2),
      width: radius * 1.4,
      height: radius * 1.6,
    );

    canvas.drawOval(ovalRect, paint);

    // Draw stem
    canvas.drawLine(
      Offset(center.dx, center.dy + radius * 0.6),
      Offset(center.dx, center.dy + radius * 0.9),
      paint,
    );

    // Draw base
    canvas.drawCircle(
      Offset(center.dx, center.dy + radius * 0.9),
      radius * 0.4,
      paint,
    );

    // Add wine if filled
    if (filled) {
      final winePaint = Paint()
        ..color = color.withValues(alpha: 0.7)
        ..style = PaintingStyle.fill;

      final wineRect = Rect.fromCenter(
        center: Offset(center.dx, center.dy + radius * 0.1),
        width: radius * 1.2,
        height: radius * 0.8,
      );

      canvas.drawOval(wineRect, winePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for shot glass
class ShotGlassPainter extends CustomPainter {
  final Color color;
  final bool filled;

  ShotGlassPainter({required this.color, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final width = size.width * 0.4;
    final height = size.height * 0.6;

    // Draw shot glass (small rectangle)
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: width, height: height),
      const Radius.circular(2),
    );

    canvas.drawRRect(rect, paint);

    // Add liquid if filled
    if (filled) {
      final liquidPaint = Paint()
        ..color = color.withValues(alpha: 0.8)
        ..style = PaintingStyle.fill;

      final liquidRect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx, center.dy + height * 0.1),
          width: width * 0.8,
          height: height * 0.8,
        ),
        const Radius.circular(2),
      );

      canvas.drawRRect(liquidRect, liquidPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
