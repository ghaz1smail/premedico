import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  final bool green;
  final double size;
  const CustomLoading({super.key, this.green = true, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
          'assets/lotties/${green ? 'loading_green' : 'loading_white'}.json',
          height: size),
    );
  }
}
