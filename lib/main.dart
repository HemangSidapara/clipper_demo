import 'package:clipper_demo/clip_shadow_path.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MaterialApp(
          title: 'Clipper Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: Home(),
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // shadow: Shadow(
  //   blurRadius: 8,
  //   color: Colors.grey.withOpacity(0.5),
  //   offset: const Offset(0, 1.5),
  // ),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F5F8),
      body: Padding(
        padding: EdgeInsets.only(top: 14.8.h, left: 5.w, right: 5.w),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 9.h),
              child: ClipShadowPath(
                clipper: CircularNotchedRClipper(30.w),
                shadow: Shadow(
                  blurRadius: 8,
                  color: Colors.black38,
                  offset: const Offset(0, 1.5),
                ),
                child: Container(
                  height: 22.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage('https://media.istockphoto.com/id/828156368/photo/demo.jpg?s=612x612&w=0&k=20&c=JIREJlrI5vY33-hLNn8vz_GREOoTIFLfSsOSkgYJ_ms='),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularNotchedRClipper extends CustomClipper<Path> {
  late final double space;

  CircularNotchedRClipper(this.space);

  @override
  Path getClip(Size size) {
    final path = Path();
    final halfWidth = size.width / 2;
    final halfSpace = space / 2;
    final curve = space / 6;
    final height = halfSpace / 2;
    // final height = halfSpace / 1.4;
    path.lineTo(halfWidth - halfSpace - 10, 0);
    path.cubicTo(halfWidth - 5.w, 0, halfWidth - halfSpace + space / 6, height, halfWidth, height);
    // path.cubicTo(halfWidth - halfSpace, 0, halfWidth - halfSpace + curve, height, halfWidth, height);

    path.cubicTo(halfWidth + 28, height, halfWidth + halfSpace - 18, 0, halfWidth + halfSpace, 0);
    // path.cubicTo(halfWidth, height, halfWidth + halfSpace - curve, height, halfWidth + halfSpace, 0);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // final path = Path()
    //   ..lineTo(size.width * 0.1, 0)
    //   ..quadraticBezierTo(size.width * 0.23, size.height / 2000, size.width * 0.25, size.height * 0.2)
    //   ..quadraticBezierTo(size.width * 0.25, size.height * 0.38, size.width * 0.5, size.height * 0.4)
    //   ..quadraticBezierTo(size.width * 0.75, size.height * 0.38, size.width * 0.75, size.height * 0.2)
    //   ..quadraticBezierTo(size.width * 0.77, size.height / 2000, size.width * 0.90, 0)
    //   ..lineTo(size.width, 0)
    //   ..lineTo(size.width, size.height)
    //   ..lineTo(0, size.width);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
