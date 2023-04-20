import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeIcon extends StatefulWidget {
  const HomeIcon({super.key});

  @override
  State<HomeIcon> createState() => _HomeIconState();
}

class _HomeIconState extends State<HomeIcon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.network(
            'https://assets1.lottiefiles.com/packages/lf20_op2rphyq.json'),
      ),
    );
  }
}
