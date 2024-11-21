part of 'header.dart';

class HeaderCurveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double curveHeight = size.height / 5;
    Path path = Path()
      ..lineTo(0, height - curveHeight)
      ..quadraticBezierTo(
        width / 2,
        height,
        width,
        height - curveHeight,
      )
      ..lineTo(width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
