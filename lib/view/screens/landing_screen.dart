import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        key: _key,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 100, width: 190),
                const Text(
                  " Choose User  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
                ),
                const SizedBox(
                  width: 130,
                  height: 80,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 130,
                      width: 120, // height of the button
                      decoration: const BoxDecoration(
                        shape:
                            BoxShape.circle, // shape makes the circular button

                        color: Color.fromARGB(255, 13, 154, 126),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: const Text('Doctor',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      height: 130,
                      width: 120, // height of the button
                      decoration: const BoxDecoration(
                        shape:
                            BoxShape.circle, // shape makes the circular button

                        color: Color.fromARGB(255, 208, 227, 209),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: const Text('Patient',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    //      const SizedBox(
                    //      width: 100,
                    //    height: 80,
                    //),
                  ],
                ),

                //////////////
                ///
                const SizedBox(height: 130, width: 190),

                //                 Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //               InkWell(
                //               onTap: null,
                //             child: Container(
                //             height: 50,
                //           width: 240,
                //         decoration: BoxDecoration(
                //         color: Color.fromARGB(255, 13, 154, 126),
                //     borderRadius: BorderRadius.circular(10),
                //     ),
                ///                      child: const Center(
                //                       child: Text(
                //                   "Continue ",
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                 fontWeight: FontWeight.bold),
                //         )),
                //     ),
                // ),
                // SizedBox(),
                //          ],
                //      ),/////
              ],
            ),
          ],
        ),
      ),
    );
  }
}
