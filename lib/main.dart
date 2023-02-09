import 'dart:math';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ClipShadowPath(
          clipper: CircularNotchedRClipper(30.w),
          shadow: Shadow(
            blurRadius: 8,
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 1.5),
          ),
          child: Container(
            height: 30.h,
            width: 90.w,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Spacer(),
              ],
            ),
          ),
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
    path.lineTo(halfWidth - halfSpace, 0);
    // path.cubicTo(halfWidth - 8.w, 0, halfWidth - halfSpace + space / 6, height, halfWidth, height);
    path.cubicTo(halfWidth - halfSpace, 0, halfWidth - halfSpace + curve, height, halfWidth, height);

    // path.cubicTo(halfWidth, height, halfWidth + halfSpace - curve, height, halfWidth + halfSpace, 0);
    path.cubicTo(halfWidth, height, halfWidth + halfSpace - curve, height, halfWidth + halfSpace, 0);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
