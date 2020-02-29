import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as Math;
import 'Utils.dart';

class AwesomeBottomNavBarShadowPainter extends CustomPainter {
    final numberOfTabs;
    final notchHeight = Utils.getIndependentDimen(52.0);
    final topPaddingFactor = 0.2;

    final double animatedIndex;

    AwesomeBottomNavBarShadowPainter(
        this.animatedIndex,
        this.numberOfTabs,
        );

    @override
    void paint(Canvas canvas, Size size) {
        var path = Path();
        path.moveTo(0, 0);

        // Draw notch
        final sectionWidth = size.width / numberOfTabs;

        final curveControlOffset = sectionWidth * 0.45;

        final topPadding = topPaddingFactor * size.height;

        path.lineTo((animatedIndex * sectionWidth) - curveControlOffset, 0);

        final firstControlPoint = Offset((animatedIndex * sectionWidth), 0);

        final secondControlPoint =
        Offset((animatedIndex * sectionWidth), notchHeight);
        final secondEndPoint = Offset(
            (animatedIndex * sectionWidth) + curveControlOffset, notchHeight);

        path.cubicTo(
            firstControlPoint.dx,
            firstControlPoint.dy,
            secondControlPoint.dx,
            secondControlPoint.dy,
            secondEndPoint.dx,
            secondEndPoint.dy);

        path.lineTo(((animatedIndex + 1) * sectionWidth) - curveControlOffset,
            notchHeight);
        final thirdControlPoint =
        Offset(((animatedIndex + 1) * sectionWidth), notchHeight);

        final fourthControlPoint =
        Offset(((animatedIndex + 1) * sectionWidth), 0);
        final fourthEndPoint =
        Offset(((animatedIndex + 1) * sectionWidth) + curveControlOffset, 0);

        path.cubicTo(
            thirdControlPoint.dx,
            thirdControlPoint.dy,
            fourthControlPoint.dx,
            fourthControlPoint.dy,
            fourthEndPoint.dx,
            fourthEndPoint.dy);
        path.lineTo(size.width, 0);

        path = path.transform(
            Matrix4.translation(Math.Vector3(0, topPadding, 0)).storage
        );

        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
        path.close();

        canvas.drawShadow(path, Colors.black, 14, false);
    }

    @override
    bool shouldRepaint(AwesomeBottomNavBarShadowPainter oldDelegate) {
        return oldDelegate.animatedIndex != animatedIndex;
    }
}