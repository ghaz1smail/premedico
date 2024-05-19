// import 'package:flutter/material.dart';
// //import 'package:firebase_core/firebase_core.dart';

// void main() {
//   runApp(const MyApp());
// }
 
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
 
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//           image: NetworkImage(
//               'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA1L3YxMTIzLWJnLTAwNWMteC5qcGc.jpg'),
//           fit: BoxFit.cover,
//         )),
//         child: const Center(
//           child: Text(
//             "PreMedico",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 33,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 2,
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
// }
 
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
 
//   final String title;
 
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
 
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           ElevatedButton(
//             onPressed: () {},
//             child: Text("Get Started "),
//           ),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }