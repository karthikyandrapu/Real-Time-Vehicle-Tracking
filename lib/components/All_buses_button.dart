// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:roomates/components/location1.dart';

// class MyAnimatedButton extends StatefulWidget {
//   @override
//   _MyAnimatedButtonState createState() => _MyAnimatedButtonState();
// }

// class _MyAnimatedButtonState extends State<MyAnimatedButton>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )..repeat(); // Repeats the animation continuously
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AllBuses(),
//               ),
//             );
//           },
//           child: AnimatedBuilder(
//             animation: _controller,
//             builder: (context, child) {
//               return CustomPaint(
//                 painter: WavesPainter(
//                   animation: _controller,
//                   color: Colors.blue.withOpacity(0.3),
//                   waveHeight: 10.0,
//                   waveCount: 3,
//                 ),
//                 child: Container(
//                   width: 200,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(30),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.blue.withOpacity(0.3),
//                         blurRadius: 5.0,
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Press Me",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         SizedBox(height: 20),
//         Text(
//           "Continuous waving animation",
//           style: TextStyle(fontSize: 16),
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class WavesPainter extends CustomPainter {
//   final Animation<double> animation;
//   final Color color;
//   final double waveHeight;
//   final int waveCount;

//   WavesPainter({
//     required this.animation,
//     required this.color,
//     required this.waveHeight,
//     required this.waveCount,
//   }) : super(repaint: animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;

//     final path = Path();
//     final waveWidth = size.width / (waveCount * 2);

//     for (var i = 0; i < waveCount; i++) {
//       final waveX = i * waveWidth * 2;
//       final waveY = size.height / 2;
//       path.moveTo(waveX, waveY);
//       path.quadraticBezierTo(
//         waveX + waveWidth,
//         waveY + waveHeight * sin(animation.value * pi * 2 + i * pi / waveCount),
//         waveX + waveWidth * 2,
//         waveY,
//       );
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
